  class Cfg
    attr :git_bundles
    attr :vim_org_scripts
    attr :gem_plugins
    attr :bundles_dir
    attr :gem_plugin_dir

    load 'plugins.cfg'
    include PluginsCfg

    def initialize
      @git_bundles      = GIT_BUNDLES
      @vim_org_scripts  = VIM_ORG_SCRIPTS
      @gem_plugins      = GEM_PLUGINS
      @bundles_dir      = File.join(File.dirname(__FILE__), "..", "bundle")
      @gem_plugin_dir   = File.join(File.dirname(__FILE__), "..", GEM_PLUGIN_DIR)
    end
  end

