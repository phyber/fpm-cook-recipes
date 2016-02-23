class Neovim < FPM::Cookery::Recipe
    description 'vim, out of the box'

    name    'neovim'
    version '0.1.2'

    source  "https://github.com/neovim/neovim/archive/v#{version}.tar.gz"
    sha256  '549881465eff82454660ae92d857d6ffa22383d45c94c46f3753fd1b0e699247'

    def after_source_extraction(sourcedir)
        @sourcedir = sourcedir
    end

    def before_build
        Dir.chdir @sourcedir do
            FileUtils.mkdir 'build' unless File.exist? 'build'
            FileUtils.mkdir '.deps' unless File.exist? '.deps'
        end
    end

    def build
        cmake_args = [
            'CMAKE_BUILD_TYPE=RelWithDebInfo',
            'CMAKE_INSTALL_PREFIX=/usr',
        ].map { |a| "-D#{a}" }

        # Build deps
        puts "Building third-party deps"
        Dir.chdir '.deps' do
            sh 'cmake', '../third-party'
            make
        end

        puts "Building Neovim"
        Dir.chdir 'build' do
            sh 'echo', 'cmake', '..', *cmake_args
            sh 'cmake', '..', *cmake_args
            make
        end
    end

    def install
        make :install,
            'VERBOSE' => '1',
            'DESTDIR' => destdir
    end

    def after_install
        sh 'gzip', '-9', Dir.glob(man/'man?/*.?')
        sh 'strip', Dir.glob(bin/'*')
    end
end
