class RustCargo < FPM::Cookery::Recipe
    description 'A systems programming language.'

    name        'cargo'
    version     '0.7.0'
    revision    '1'

    homepage    'https://crates.io/'
    source      'https://github.com/rust-lang/cargo',
        :with      => :git,
        :tag       => version,
        :submodule => true

    platforms [:debian] do
        # build-essential pulls in:
        #   gcc, g++, make, libc6-dev, dpkg-dev
        # ccache helps with building newer versions or repeated builds when
        # fixing the recipe.
        build_depends %w(
            build-essential
            ccache
            curl
            git
            python2.7-dev
        )
    end

    # Workaround for :git :submodule happening too early.
    def after_source_download
        Dir.chdir cachedir/name do
            sh "git checkout #{version}"
            sh 'git submodule update --init'
        end
    end

    def before_build
        configure \
            :prefix          => prefix,
            :local_rust_root => destdir/prefix
    end

    def build
        make '--jobs' => 3
    end

    def install
        make :install, 'DESTDIR' => destdir
    end
end
