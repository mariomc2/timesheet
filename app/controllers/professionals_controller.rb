class ProfessionalsController < ApplicationController
  
  layout "professional"

  before_action :set_locale
  before_action :find_user

  def index
    if @user
      @professionals = @user.professionals
    else
      @professionals = Professional.all
    end
  end

  def show
    @professional = Professional.find(params[:id])
  end

  def new
    if @user
      @professional = @user.professionals.new
    else
      @professional = Professional.new
    end    
  end

  def create
    # Instantiate a new object using form parameters
    @professional = Professional.new(professional_params)
    # Save the object
    if @professional.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "#{t(:professional)} #{t(:create_success)}"
      redirect_to([@user, :professionals])      
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
      redirect_to([@user, @professional])
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
    redirect_to([@user, :professionals])
  end

  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def professional_params
      # same as using "params[:professional]", except taht it:
      # - raises an error if :professional is not present
      # - allows listed attributes to be mass-assigned
      params.require(:professional).permit(:first_name, :last_name, :id_code, :dob, :email, :speciality)
    end

    def find_user
      # Take the URL to extract the resource: [Professional, Company]
      resource= request.path.split('/')[2]
      if params[resource.singularize+"_id"]
        @user = resource.singularize.classify.constantize.find(params[resource.singularize+"_id"])
      end
    end
end