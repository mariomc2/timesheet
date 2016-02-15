class ClientsController < ApplicationController

  layout "professional"

  before_action :set_locale
  before_action :find_user

  def index
    if not(@is_company) && params[:company_id]
      @clients = @user.clients.where(company_id: params[:company_id])
    elsif @is_company && params[:professional_id]
      @clients = @user.clients.joins(:professionals).where(professionals: {id: params[:professional_id]})
    else
      @clients = @user.clients
    end    
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = @user.clients.new()
  end

  def create
    # Instantiate a new object using form parameters
    @client = Client.new(client_params)
    @user.clients << @client
    # Save the object
    if @client.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "#{t(:client)} #{t(:create_success)}"
      redirect_to([@user, :clients])
    else
    # If save fails, redisplay the from so user can fix problems
      render('new')
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    # Find and existing object using form parameters
    @client = Client.find(params[:id])
    # Update the object
    if @client.update_attributes(client_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "#{t(:client)} #{t(:update_success)}"
      redirect_to([@user, @client])
    else
      # If save fails, redisplay the from so user can fix problems
      render('edit')
    end
  end

  def delete
    @client = Client.find(params[:id])
  end

  def destroy
    client = Client.find(params[:id]).destroy
    flash[:notice] = "#{t(:client)} '#{client.first_name}' #{t(:destroy_success)}"
    redirect_to([@user, :clients])
  end

  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def client_params
      # same as using "params[:appointment]", except taht it:
      # - raises an error if :appointment is not present
      # - allows listed attributes to be mass-assigned
      params.require(:client).permit(:company_id, :branch_id, :id_code, :first_name, :last_name, :dob, :email, :photo)
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
