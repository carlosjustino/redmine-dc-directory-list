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

  project_module :fnt_progress_module do
    permission :view_file_progress, :fntprogress => :index
    permission :add_file_progress, :fntprogress => :telafiltroanexos
  end
  
end


