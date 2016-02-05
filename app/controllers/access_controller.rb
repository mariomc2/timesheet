class AccessController < ApplicationController
  
  layout "application"

  before_action :set_locale

  def index
    @professionals = Professional.all
    @companies = Company.all
    render('login')
  end

  
  def login
    @professionals = Professional.all
    @companies = Company.all
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

  def professional_new
      @professional = Professional.new
      render('professional_new')    
  end

  def professional_create
    # Instantiate a new object using form parameters
    @professional = Professional.new(professional_params)
    # Save the object
    if @professional.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "#{t(:professional)} #{t(:create_success)}"
      redirect_to(:action => 'login')      
    else
    # If save fails, redisplay the from so user can fix problems
      render('professional_new')
    end
  end

  def professional_delete
    @professional = Professional.find(params[:id])
  end

  def professional_destroy
    professional = Professional.find(params[:id]).destroy
    flash[:notice] = "#{t(:professional)} '#{professional.email}' #{t(:destroy_success)}"
    redirect_to(:action => 'login')
  end

  def company_new
      @company = Company.new
      render('company_new')    
  end

  def company_create
    # Instantiate a new object using form parameters
    @company = Company.new(company_params)
    # Save the object
    if @company.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "#{t(:company)} #{t(:create_success)}"
      redirect_to(:action => 'login')      
    else
    # If save fails, redisplay the from so user can fix problems
      render('company_new')
    end
  end

  def company_delete
    @company = Company.find(params[:id])
  end

  def company_destroy
    company = Company.find(params[:id]).destroy
    flash[:notice] = "#{t(:company)} '#{company.email}' #{t(:destroy_success)}"
    redirect_to(:action => 'login')
  end


  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def professional_params
      # same as using "params[:professional]", except taht it:
      # - raises an error if :professional is not present
      # - allows listed attributes to be mass-assigned
      params.require(:professional).permit(:first_name, :last_name, :id_code, :dob, :email, :speciality, :acc_active)
    end

    def company_params
      # same as using "params[:company]", except taht it:
      # - raises an error if :company is not present
      # - allows listed attributes to be mass-assigned
      params.require(:company).permit(:name, :id_code, :email, :acc_active)
    end
end
