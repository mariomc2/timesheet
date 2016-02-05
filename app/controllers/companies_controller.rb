class CompaniesController < ApplicationController
  
  layout "professional"

  before_action :set_locale
  before_action :find_user

  def index
    if @user
      @companies = @user.companies
    else
      @companies = Company.all
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    if @user
      @company = @user.companies.new
    else
      @company = Company.new
    end    
  end

  def create
    # Instantiate a new object using form parameters
    @company = Company.new(company_params)
    @company.professionals << @user
    # Save the object
    if @company.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "#{t(:company)} #{t(:create_success)}"
      redirect_to([@user, :companies])      
    else
    # If save fails, redisplay the from so user can fix problems
      render('new')
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    # Find and existing object using form parameters
    @company = Company.find(params[:id])
    # Update the object
    if @company.update_attributes(company_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "#{t(:company)} #{t(:update_success)}"
      redirect_to([@user, @company])
    else
      # If save fails, redisplay the from so user can fix problems
      render('edit')
    end
  end

  def delete
    @company = Company.find(params[:id])
  end

  def destroy
    company = Company.find(params[:id]).destroy
    flash[:notice] = "#{t(:company)} '#{company.email}' #{t(:destroy_success)}"
    redirect_to([@user, :companies])
  end

  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def company_params
      # same as using "params[:company]", except taht it:
      # - raises an error if :company is not present
      # - allows listed attributes to be mass-assigned
      params.require(:company).permit(:name, :id_code, :email)
    end

    def find_user
      # Take the URL to extract the resource: [Professional, Company]
      resource= request.path.split('/')[2]
      if params[resource.singularize+"_id"]
        @user = resource.singularize.classify.constantize.find(params[resource.singularize+"_id"])
      end
    end
end
