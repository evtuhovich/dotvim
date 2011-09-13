# vim: set ft=ruby :
#
# The Idea by Ivan Evtukhovich
# Rakefile edition by Pavel Argentov

$:.unshift File.dirname __FILE__
require 'cfg'
require 'open-uri'

namespace :bundles do

  cfg = Cfg.new

  directory cfg.bundles_dir

  desc "Update the plugins"
  task :update => cfg.bundles_dir do

    puts "Updating the plugins"

    cd cfg.bundles_dir do
      cfg.git_bundles.each do |url|
        dir = url.split('/').last.sub(/\.git$/, '')

        puts "  Unpacking #{url} into #{dir}"
        if File.exist? dir
          system "cd #{dir} && git pull"
        else
          system "git clone #{url} #{dir}"
        end
      end

      cfg.vim_org_scripts.each do |name, script_id, script_type|
        puts "  Downloading #{name}"
        local_file = File.join(name, script_type, "#{name}.vim")
        mkdir_p(File.dirname(local_file))
        File.open(local_file, "w") do |file|
          file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
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
      s = sym.to_s
      desc "#{s} plugins available via rubygems"
      task sym do
        cfg.gem_plugins.each do |gem, cmd|
          c = "gem #{s} #{gem} #{"&& #{cmd}" unless sym == :uninstall}"
          puts c
          system c
        end
      end
    end

    desc "reinstall plugins available via rubygems"
    task :reinstall => [:uninstall, :install]

    directory cfg.gem_plugin_dir
    desc "cleaning up after gemmed plugins"
    task :cleanup => [cfg.gem_plugin_dir, :uninstall] do
      remove_entry_secure cfg.gem_plugin_dir
    end

  end
end
