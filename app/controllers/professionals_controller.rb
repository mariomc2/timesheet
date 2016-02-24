class ProfessionalsController < ApplicationController
  
  layout "professional"

  before_action :set_locale
  before_action :current_user

  def login
    render layout: false
  end

  def index
    if @is_company # If the user is a Company
      @professionals = @current_user.professionals
    else # If the user is professional pass the whole list ONLY for testing
      @professionals = Professional.all
    end
  end

  def show
    @professional = Professional.find(params[:id])
  end

  def new
    begin
      if @current_user @is_company # If the user is a company and is creating a new virtual professional
        @professional = @current_user.professionals.new
      else # kicks in when registering a new Professional
        @professional = Professional.new
      end    
    rescue Exception => e # Catch exceptions 
      flash[:notice] = e.to_s
      redirect_to([@current_user, :professionals])
    end
  end

  def create
    # Instantiate a new object using form parameters
    professional = Professional.new(professional_params)
      
    # Save the object
    if professional.save
      begin
        if !@is_company # If user is a professional then create a virtual company and default (empty) children
          company = professional.companies.create(default: true, name: "-")
          branch = company.branches.create(default: true, name: "-")
          client = branch.clients.create(default: true, company_id: company.id, dob: "1900-01-01", first_name: "-", last_name: "-")
          professional.clients << client
        else # if the user is a company just make the proper associations to the new virtual professional
        end      

        # If save succeeds, redirect to the index action
        flash[:notice] = "#{t(:professional)} #{t(:create_success)}"
        redirect_to([@current_user, :professionals])  

      rescue Exception => e # Catch exceptions if it can't create the children of a company
        # If there is an exception delete the objects created and redirect to index
        professional.destroy
        if branch then branch.destroy end        
        if client then client.destroy end
        if company then company.destroy end

        flash[:notice] = "#{t(:professional)}->" + e.to_s
        redirect_to([@current_user, :professionals])
      end  
    else
    # If save fails, redisplay the from so user can fix problems
      render('new')
    end
  end

  def edit
    @professional = Professional.find(params[:id])
  end

  def update
    # Find and existing object using form parameters
    @professional = Professional.find(params[:id])
    # Update the object
    if @professional.update_attributes(professional_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "#{t(:professional)} #{t(:update_success)}"
      redirect_to([@current_user, @professional])
    else
      # If save fails, redisplay the from so user can fix problems
      render('edit')
    end
  end

  def delete
    @professional = Professional.find(params[:id])
  end

  def destroy
    professional = Professional.find(params[:id]).destroy
    flash[:notice] = "#{t(:professional)} '#{professional.email}' #{t(:destroy_success)}"
    redirect_to([@current_user, :professionals])
  end

  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def professional_params
      # same as using "params[:professional]", except taht it:
      # - raises an error if :professional is not present
      # - allows listed attributes to be mass-assigned
      params.require(:professional).permit(:id_token, :first_name, :last_name, :id_code, :dob, :email, :speciality, :default, :time_zone)
    end
end