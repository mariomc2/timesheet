class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  MAX_RETRIES_IDTOKEN = 3

  # around_filter :set_time_zone

  # def set_time_zone(&block)
  #   time_zone = current_user.try(:time_zone) || 'UTC'
  #   Time.use_zone(time_zone, &block)
  # end
  
  def default_url_options(options = {})
  	{ locale: I18n.locale }.merge options
	end

	def set_api_time_zone
	  utc_offset = current_user_session && current_user_session.user ? current_user_session.user.time_zone_offset.to_i.minutes : 0
	  user_timezone = ActiveSupport::TimeZone[utc_offset]
	  Time.zone = user_timezone if user_timezone
	end
end
