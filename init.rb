require 'redmine'
require 'fntprogress/hooks.rb'
require 'socket'
require 'socketprogress'


Redmine::Plugin.register :fntprogress do
  name 'Integração com FNT plugin'
  author 'Carlos Eduardo Justino'
  description 'Plugin para o Redmine que permiti a comunição com o FNT(Progress)'
  version '1.0.0'
  url 'https://carlosjustino.github.io/redmine-fntprogress'
  author_url 'http://carlosjustino.eti.br/'

  settings :default => {'hostfnt' => "", 'portfnt' => ""},
           :partial => 'settings/fntprogress_settings'

  requires_redmine :version_or_higher => '3.0.0'

  project_module :fnt_progress_module do
    permission :view_file_progress, {}
    permission :add_file_progress, {}
    permission :remove_file_progress, {}
  end

end


