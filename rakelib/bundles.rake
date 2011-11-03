# vim: set ft=ruby :
#
# The Idea by Ivan Evtukhovich
# Rakefile edition by Pavel Argentov

$:.unshift File.dirname __FILE__
require 'cfg'
require 'open-uri'

namespace :bundles do

  Cfg.new.tap do |cfg|

    directory cfg.bundles_dir

    desc "Update the plugins"
    task :update => cfg.bundles_dir do

      puts "Updating the plugins"

      cd cfg.bundles_dir do
        cfg.git_bundles.each do |url|
          url.split('/').last.sub(/\.git$/, '').tap do |dir|

            puts "  Unpacking #{url} into #{dir}"
            if File.exist? dir
              system "cd #{dir} && git pull"
            else
              system "git clone #{url} #{dir}"
            end
          end
        end

        cfg.vim_org_scripts.each do |name, script_id, script_type|
          puts "  Downloading #{name}"
          File.join(name, script_type, "#{name}.vim").tap do |local_file|
            mkdir_p(File.dirname(local_file))
            File.open(local_file, "w") do |file|
              file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
            end
          end
        end

        # update helptags
        Dir["*/doc"].map { |dir| %Q[-c "helptags #{dir}"]}.each_slice(8) do |params|
          puts %Q[vim #{params.join(' ')} -c"quit"]
          `vim #{params.join(' ')} -c"quit"`
        end
      end
    end

    namespace :gemmed do
      [
        :install,
        :update,
        :uninstall
      ].each do |sym|
        sym.to_s.tap do |s|
          desc "#{s} plugins available via rubygems"
          task sym do
            cfg.gem_plugins.each do |gem, cmd|
              "gem #{s} #{gem} #{"&& #{cmd}" unless sym == :uninstall}".tap do |c|
                puts c
                system c
              end
            end
          end
        end
      end

      desc "reinstall plugins available via rubygems"
      task :reinstall => [:uninstall, :install]

      directory cfg.gem_plugin_dir
      desc "clean up after gemmed plugins"
      task :cleanup => [cfg.gem_plugin_dir, :uninstall] do
        remove_entry_secure cfg.gem_plugin_dir
      end
    end

    # Some hidden utility tasks:
    #
    # Snipmate snippets dirs linkage
    task :snipmate => cfg.bundles_dir do
      cd cfg.bundles_dir do
        puts "Setting up Snipmate:"
        'snipmate'.tap do |d|
          puts "Linking 'snipmate.vim' to '#{d}'"
          ln_s('snipmate.vim', d) unless File.exist? d
          cd d do
            puts "Making snippets' directory"
            'snippets'.tap do |d|
              mkdir d unless File.exist? d
            end
          end
          cd 'snipmate-snippets' do
            system 'rake'
          end
        end
      end
    end
   
    # Pathogen additional setup
    task :pathogen => cfg.bundles_dir do
      puts 'Setting up Pathogen:'
      File.join('autoload', 'pathogen.vim').tap do |n|
        File.expand_path(File.join(cfg.bundles_dir, 'vim-pathogen', n)).tap do |nn|
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
      end
    end
  end
end
