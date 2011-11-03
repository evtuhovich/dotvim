require 'rake'

desc "Default"
task :default => :setup do
  puts "The directories are set up successfully"
end

desc "Setting up the plugins' directories"
task :setup => ["bundles:update", "bundles:snipmate", "bundles:pathogen", "bundles:gemmed:install"]

# A convenience stub 
desc "Update the installed plugins"
task :update => ["bundles:update", "bundles:snipmate", "bundles:pathogen", "bundles:gemmed:update"]

desc "Remove all generated/downloaded content"
task :distclean => "bundles:gemmed:cleanup" do
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
task :reinit => [:distclean, :setup] do
  puts "Your setup is now rebuilt"
end
