class Kodi < FPM::Cookery::Recipe
	description	'Kodi Media Player'

	name		'kodi'
	version		'15.2'
	revision	'1'

	homepage	'http://kodi.tv'
	source		'https://github.com/xbmc/xbmc/archive/15.2-Isengard.tar.gz'
	sha256		'dd8aeb942e6de5d1488e243e1346cff3f6597e21b5131a3ba72ff5cc82037110'

	def before_build
		safesystem './bootstrap'
		configure :prefix => prefix
	end

	def build
		make
	end

	def install
		make :install,
			'DESTDIR' => destdir
	end
end
