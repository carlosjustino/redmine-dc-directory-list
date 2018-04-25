# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


get 'fntprogress', :to => 'fntprogress#index', :as => 'view_file_progress'
get 'fntprogress/telafiltroanexos', :to => 'fntprogress#telafiltroanexos', :as => 'search_filter_progress'
post 'fntprogress/buscararquivos', :to => 'fntprogress#buscararquivos', :as => 'search_file_progress'
post 'fntprogress/anexarfontes', :to => 'fntprogress#anexarfontes', :as => 'addlist_file_progress'
post 'fntprogress/removerfontes', :to => 'fntprogress#removerfontes', :as => 'dellist_file_progress'
get 'fntprogress/errorpage', :to => 'fntprogress#errorpage'