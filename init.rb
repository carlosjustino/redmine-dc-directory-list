require 'redmine'
require 'fntprogress/hooks.rb'
require 'socket'
require 'socketprogress'


Redmine::Plugin.register :fntprogress do
  name 'Integração com FNT plugin'
  author 'Carlos Eduardo Justino'
  description 'Plugin para o Redmine que permiti a comunição com o FNT(Progress)'
  version '1.0.0'
  url 'http://www.datacoper.com.br'
  author_url 'http://carlosjustino.eti.br/'

  permission :fntprogress, :public => false

  project_module :fnt_progress_module do
     permission :view_file_progress, :require => :loggedin
     permission :search_filter_progress, :require => :member
     permission :fntprogress, { :fntprogress => [:index, :telafiltroanexos] }, :require => :member
  end
  
end


