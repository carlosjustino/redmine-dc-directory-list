# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


get 'listdirectory', :to => 'listdirectory#index', :as => 'view_file_progress'
get 'listdirectory/anexar', :to => 'listdirectory#anexar', :as => 'add_file_progress'
get 'listdirectory/telafiltroanexos', :to => 'listdirectory#telafiltroanexos', :as => 'search_filter'
post 'listdirectory/buscararquivos', :to => 'listdirectory#buscararquivos', :as => 'search_file_progress'
post 'listdirectory', :to => 'listdirectory#create', :as => 'new_file_progress'
