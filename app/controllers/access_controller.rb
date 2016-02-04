class AccessController < ApplicationController
  
  layout "application"

  before_action :set_locale

  def login
  end

  def register
  end

  def attempt_login_professional
    redirect_to([:professionals])
  end

  def attempt_login_company

  end

  def logout

  end

  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end
end
