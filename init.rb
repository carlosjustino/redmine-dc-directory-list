unless File.basename(File.dirname(__FILE__)) == 'dc_directory_list'
  raise "Datacoper Diretectory List plugin directory should be 'dc_directory_list' instead of '#{File.basename(File.dirname(__FILE__))}'"
end

Redmine::Plugin.register :dc_directory_list do
  name 'Datacoper Diretectory List plugin'
  author 'Carlos Eduardo Justino'
  description 'Apresenta listagem de arquivos na pasta.'
  version '0.0.1'
  url 'https://github.com/carlosjustino/redmine-dc-directory-list'
  author_url 'https://github.com/carlosjustino'
  requires_redmine :version_or_higher => '3.0'

  settings :default => {
    'show_user_owner'   => true,
    'show_date_created' => true,
    'show_path'         => true,
    'orderby_recents'   => true,
  }, :partial => 'settings/dc_directory_list'
end

require 'dc_directory_list'
require 'dcdirectorylist/application_helper_patch'
=begin

    require 'dcdirectorylist/projects_helper_patch'
    require 'dcdirectorylist/projects_list_view_listener'
    require 'dcdirectorylist/recent_projects_view_listener'
=end