class CompaniesController < ApplicationController
  
  layout "professional"

  before_action :set_locale
  before_action :find_user

  def login
    render layout: false
  end

  def index
    if !@is_company # If the user is a professional
      @companies = @user.companies
    else # If the user is companies pass the whole list ONLY for testing
      @companies = Company.all
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    begin
      if !@is_company # If the user is a professional and is creating a new virtual company
        @company = @user.companies.new
      else
        @company = Company.new
      end # kicks in when registering a new Company
    rescue Exception => e # Catch exceptions 
      flash[:notice] = e.to_s
      redirect_to([@user, :companies])
    end
  end

  def create
    # Instantiate a new object using form parameters
    company = Company.new(company_params)
    
    # Save the object
    if company.save
      begin
        # Create the default (empty) children for a new company
        branch = company.branches.create(default: true, name: "-")
        client = branch.clients.create(default: true, company_id: company.id, dob: "1900-01-01", first_name: "-", last_name: "-")
        if @is_company # If user is a company then create a virtual professional
          professional = company.professionals.create(default: true, dob: "1900-01-01", first_name: "-", last_name: "-")
          professional.clients << client
        else # If user is already a professional just make the proper associations to the new virtual company 
          company.professionals << @user
          @user.clients << client
        end

        # If save succeeds, redirect to the index action     
        flash[:notice] = "#{t(:company)} #{t(:create_success)}"
        redirect_to([@user, :companies])      
      rescue Exception => e # Catch exceptions if it can't create the children of a company
        # If there is an exception delete the objects created and redirect to index
        company.destroy
        if branch then branch.destroy end        
        if client then client.destroy end
        if professional then professional.destroy end

        flash[:notice] = "#{t(:company)}->" + e.to_s
        redirect_to([@user, :companies])
      end
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
      params.require(:company).permit(:id_token, :name, :id_code, :email, :default, :time_zone)
    end

    def find_user
      # Take the URL to extract the resource: [Professional, Company]
      resource= request.path.split('/')[2]
      
      @is_company = resource == "companies" ? true : false
          
      if params[resource.singularize+"_id"]
        @user = resource.singularize.classify.constantize.find(params[resource.singularize+"_id"])
      end
    end
end