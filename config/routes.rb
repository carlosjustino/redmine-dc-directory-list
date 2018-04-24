# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


get 'listdirectory', :to => 'listdirectory#index', :as => 'view_file_progress'
get 'listdirectory/telafiltroanexos', :to => 'listdirectory#telafiltroanexos', :as => 'search_filter'
post 'listdirectory/buscararquivos', :to => 'listdirectory#buscararquivos', :as => 'search_file_progress'
post 'listdirectory/anexarfontes', :to => 'listdirectory#anexarfontes', :as => 'addlist_file_progress'
post 'listdirectory/removerfontes', :to => 'listdirectory#removerfontes', :as => 'dellist_file_progress'
get 'listdirectory/errorpage', :to => 'listdirectory#errorpage'