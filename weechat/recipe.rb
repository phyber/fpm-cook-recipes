class WeeChat < FPM::Cookery::Recipe
    description 'The extensible chat client'

    name        'weechat'
    version     '1.3'
    revision    '1'

    homepage    'https://weechat.org'
    source      "https://weechat.org/files/src/weechat-#{version}.tar.bz2"
    sha1        '3d6cac3a92b194819197ee7ed435a0c2e62a7c66'

    def before_build
        mkdir_p 'build'
        Dir.chdir 'build'
    end

    def build
        sh "cmake .. -DCMAKE_INSTALL_PREFIX=#{prefix}"
        make
    end

    def install
        make :install, 'DESTDIR' => destdir
    end
end
