class AppointmentsController < ApplicationController
  
  layout "professional"

  before_action :set_locale
  before_action :find_user

  def index
    if params[:company_id]
      @appointments = @user.appointments.where(company_id: params[:company_id])
    elsif params[:professional_id]
      @appointments = @user.appointments.where(professional_id: params[:professional_id])        
    else
      @appointments = @user.appointments
    end    
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = @user.appointments.new({:date_time => Time.now})
  end

  def create
    # Instantiate a new object using form parameters
    @appointment = Appointment.new(appointment_params)
    @user.appointments << @appointment
    # Save the object
    if @appointment.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "#{t(:appointment)} #{t(:create_success)}"
      redirect_to([@user, :appointments])
    else
    # If save fails, redisplay the from so user can fix problems
      render('new')
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    # Find and existing object using form parameters
    @appointment = Appointment.find(params[:id])
    # Update the object
    if @appointment.update_attributes(appointment_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "#{t(:appointment)} #{t(:update_success)}"
      redirect_to([@user, @appointment])
    else
      # If save fails, redisplay the from so user can fix problems
      render('edit')
    end
  end

  def delete
    @appointment = Appointment.find(params[:id])
  end

  def destroy
    appointment = Appointment.find(params[:id]).destroy
    flash[:notice] = "#{t(:appointment)} '#{appointment.date_time}' #{t(:destroy_success)}"
    redirect_to([@user, :appointments])
  end

  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def appointment_params
      # same as using "params[:appointment]", except taht it:
      # - raises an error if :appointment is not present
      # - allows listed attributes to be mass-assigned
      params.require(:appointment).permit(:company_id, :branch_id, :professional_id, :client_id, :shared, :needs_folloup, :date_time, :status, :task_type, :task_note, :total_project_price, :task_payment, :professional_fee, :remaining_project_payment)
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
