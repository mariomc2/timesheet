class ProfessionalsController < ApplicationController
  
  layout "professional"

  before_action :set_locale

  def index
    @professionals = Professional.all
  end

  def show
    @professional = Professional.find(params[:id])
  end

  def new
    @professional = Professional.new
  end

  def create
    # Instantiate a new object using form parameters
    @professional = Professional.new(professional_params)
    # Save the object
    if @professional.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "#{t(:professional)} #{t(:create_success)}"
      redirect_to(professionals_path)
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
      redirect_to(professional_path(@professional.id))
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
    redirect_to(professionals_path)
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
end