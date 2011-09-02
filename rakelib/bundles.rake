# vim: set ft=ruby :
#
# The Idea by Ivan Evtukhovich
# Rakefile edition by Pavel Argentov

namespace :bundles do

  require 'open-uri'

  class Cfg
    attr :git_bundles
    attr :vim_org_scripts
    attr :bundles_dir

    load 'plugins.cfg'
    include PluginsCfg

    def initialize
      @git_bundles      = GIT_BUNDLES
      @vim_org_scripts  = VIM_ORG_SCRIPTS
      @bundles_dir      = File.join(File.dirname(__FILE__), "..", "bundle")
    end
  end

  cfg = Cfg.new

  directory cfg.bundles_dir

  desc "Updating the plugins"
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
end
