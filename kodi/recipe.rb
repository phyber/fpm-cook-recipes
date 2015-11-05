class Kodi < FPM::Cookery::Recipe
	description 'Kodi Media Player'

	name 'kodi'
	version '15.2'
	revision '1'
	homepage 'http://kodi.tv'
	source 'https://github.com/xbmc/xbmc.git',
		:with => 'git',
		:tag => '15.2-Isengard'

	def before_build
		safesystem './bootstrap'
		# Configure Kodi
		configure :prefix => prefix

	end

	def build
		make
		# Crossguid dir created during configure.
		#make \
		#	'--directory' => 'tools/depends/target/crossguid',
		#	'PREFIX' => prefix
	end

	def install
		make :install, 'DESTDIR' => destdir
	end
end
