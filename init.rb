require 'redmine'
require 'listdirectory/hooks.rb'
require 'socket'
require 'socketprogress'


Redmine::Plugin.register :listdirectory do
  name 'DC List Directory plugin'
  author 'Carlos Eduardo Justino'
  description 'Plugin para o Redmine que permiti selecionar arquivos, granvando em uma tabela por tarefa'
  version '0.0.1'
  url 'http://www.datacoper.com.br'
  author_url 'http://carlosjustino.eti.br/'
  
  
  project_module :file_progress_module do
     permission :view_file_progress, { :listdirectory => [:index, :anexar]}
  end
  permission :listdirectory, { :listdirectory => [:index, :anexar] }
end


