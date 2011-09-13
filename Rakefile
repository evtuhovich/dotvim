require 'rake'

desc "Default"
task :default => :setup do
  puts "The directories are set up successfully"
end

desc "Settup the plugins' directories"
task :setup => ["bundles:update", "bundles:gemmed:install"] do
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
  n = File.join 'autoload', 'pathogen.vim'
  nn = File.expand_path File.join 'bundle', 'vim-pathogen', n
  puts "Linking #{nn} ->  #{n}"
  begin
    ln_sf nn, n
  rescue => error
    if error.class == Errno::ENOENT
      mkdir_p File.dirname n
      retry
    elsif error.class == Errno::ENOTDIR
      remove_entry_secure File.dirname n
      retry
    else
      puts error.inspect
    end
  end
end

# A convenience stub 
desc "Update the installed plugins"
task :update => ["bundles:update", "bundles:gemmed:update"]

desc "Remove all generated/downloaded content"
task :clean => "bundles:gemmed:cleanup" do
  puts 'Removing the generated content:'
  ['bundle', File.join('autoload', 'pathogen.vim')].each do |d|
    puts "  -> #{d}"
    begin
      remove_entry_secure d
    rescue
    end
  end
end

desc "Rebuild everything"
task :reinit => [:clean, :setup] do
  puts "Your setup is now rebuilt"
end
