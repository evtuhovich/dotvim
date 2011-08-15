require 'rake'
desc "Default"
task :default => :setup do
	puts "The directories are set up successfully"
end

desc "Setting up the directories"
task :setup	do
	puts "Updating the bundles with the script"
	puts `./update_bundles`
	cd 'bundle' do
		puts "Setting up the Snipmate:"
		d = 'snipmate'
		puts "Linking 'snipmate.vim' to #{d}"
		ln_s('snipmate.vim', d) unless File.exist? d
		cd d do
			puts "Making snippets' directory"
			d = 'snippets'
			mkdir d unless File.exist? d
		end
		cd 'snipmate-snippets' do
			puts `rake`
		end
	end
end

desc "Cleaning everyting up"
task :clean do
	puts 'Removing the generated dirs'
	d = 'bundle'
	rm_rf d, :verbose => true  if File.exist? d
end

desc "Rebuild everything"
task :reinit => [:clean, :setup] do
	puts "Your setup is now rebuilt"
end
