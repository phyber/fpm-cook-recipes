class Abduco < FPM::Cookery::Recipe
    description 'A tool for session {at,de}tach support'

    name        'abduco'
    version     '0.4'
    revision    '1'

    homepage    'https://github.com/martanne/abduco'
    source      'https://github.com/martanne/abduco.git',
        :with   => :git,
        :tag    => "v#{version}"

    build_depends %w(
        build-essential
    )

    def build
        make :prefix => prefix
    end

    def install
        make :install,
            'PREFIX'  => '/usr',
            'DESTDIR' => destdir
    end

    def after_install
        # Compress manpages.
        sh "gzip -9 #{Dir.glob(man/'*/*.?').join(' ')}"
    end
end
