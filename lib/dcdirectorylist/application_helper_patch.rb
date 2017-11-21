module DCDirectoryList::ApplicationHelperPatch
  def self.included(base) # :nodoc:
    base.class_eval do

      def dcdirectorylist_setting(key)
        if request.params[:dcdirectorylist]
          session[:dcdirectorylist] = true
          session[key] = request.params[key]
        elsif session[:dcdirectorylist]
          session[key]
        else
          Setting.plugin_dc_directory_list[key.to_s]
        end
      end

      def dcdirectorylist_setting?(key)
        dcdirectorylist_setting(key).present?
      end
    end
  end
end

unless ApplicationHelper.include? DCDirectoryList::ApplicationHelperPatch
  ApplicationHelper.send(:include, DCDirectoryList::ApplicationHelperPatch)
end
