require 'rake'
desc "Default"
task :default => :setup do
	puts "The directories are set up successfully"
end

desc "Setting up the directories"
task :setup	do
	puts "Updating the bundles with the script"
	system './update_bundles'
	cd 'bundle' do
		puts "Setting up Snipmate:"
		d = 'snipmate'
		puts "Linking 'snipmate.vim' to '#{d}'"
		ln_s('snipmate.vim', d) unless File.exist? d
		cd d do
			puts "Making snippets' directory"
			d = 'snippets'
			mkdir d unless File.exist? d
		end
		cd 'snipmate-snippets' do
			system 'rake'
		end
	end

	puts 'Setting up Pathogen:'
	n = File.expand_path File.join 'bundle', 'vim-pathogen', 'autoload', 'pathogen.vim'
	puts "Linking #{n} -> autoload"
	begin
		ln_sf n, 'autoload'
	rescue => error
		if error.class == Errno::ENOENT
			mkdir 'autoload'
			retry
		else
			puts error.inspect
		end
	end
end

desc "Removing all generated/downloaded content"
task :clean do
	puts 'Removing the generated content:'
	['bundle', File.join('autoload', 'pathogen.vim')].each do |d|
		puts "  -> #{d}"
		remove_entry_secure d if File.exist? d
	end
end

desc "Rebuild everything"
task :reinit => [:clean, :setup] do
	puts "Your setup is now rebuilt"
end
