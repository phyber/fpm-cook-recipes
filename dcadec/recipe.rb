class DCADEC < FPM::Cookery::Recipe
	homepage	'https://github.com/foo86/dcadec'
	source		'https://github.com/foo86/dcadec.git',
				:with	=> 'git',
				:branch	=> 'master'

	name		'libdcadec'
	version		'0.0.1'
	revision	'1'

	description	'DTS Coherent Acoustics decoder with support for HD extensions'

	def build
		make
	end

	def install
		make :install,
			'DESTDIR' => destdir,
			'PREFIX' => '/usr'
	end
end
