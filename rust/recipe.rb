class Rustibus < FPM::Cookery::Recipe
    description 'A systems programming language.'

    name        'rust'
    version     '1.5.0'
    revision    '1'

    homepage    'https://www.rust-lang.org/'
    source      '',
        :with   => :noop

    # Omnibus package lets us package Cargo with this.
    omnibus_package true
    omnibus_recipes %w(
        rust
        cargo
    )

    # Hack to fix up the :input path allowing us to use Omnibus packaging for
    # a new purpose. eg. Installing both rust and cargo to the same prefix and
    # packaging them up in a single package.
    def input(config)
        config.delete(:input)
        super config
    end

    def build
    end

    def install
    end
end
