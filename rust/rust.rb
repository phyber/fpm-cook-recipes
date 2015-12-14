class Rust < FPM::Cookery::Recipe
    description 'A systems programming language.'

    name        'rust'
    version     '1.5.0'
    revision    '1'

    homepage    'https://www.rust-lang.org/'
    source      "https://static.rust-lang.org/dist/rustc-#{version}-src.tar.gz"
    sha256      '641037af7b7b6cad0b231cc20671f8a314fbf2f40fc0901d0b877c39fc8da5a0'

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

    def before_build
        configure \
            :prefix        => prefix,
            :enable_ccache => true,
            :disable_docs  => true
    end

    def build
        make '--jobs' => 3
    end

    def install
        make :install, 'DESTDIR' => destdir
    end
end
