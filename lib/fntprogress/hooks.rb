class RedmineProgressFilePageHooks < Redmine::Hook::ViewListener
  
  render_on :view_layouts_base_html_head, :partial => 'fntprogress/button_page', :layout => false

end