class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :user_time_zone, if: :current_user

  helper_method :current_user

  def current_user
    # Take the URL to extract the resource: [Professional, Company]
    resource= request.path.split('/')[2]
    
    @is_company = resource == "companies" ? true : false
        
    if resource && params[resource.singularize+"_id"]
      @current_user = resource.singularize.classify.constantize.find(params[resource.singularize+"_id"])
    end
  end
  
  def default_url_options(options = {})
  	{ locale: I18n.locale }.merge options
	end

	def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
	end
end
