class AppointmentsController < ApplicationController
  
  layout "professional"

  before_action :set_locale
  before_action :find_professional

  def index
    # @appointments = ProfessionalAppointment.all
    @appointments = @professional.professional_appointments
  end

  def show
    @appointment = ProfessionalAppointment.find(params[:id])
  end

  def new
    @appointment = ProfessionalAppointment.new({:professional_id => @professional.id, :date_time => Time.now})
  end

  def create
    # Instantiate a new object using form parameters
    @appointment = ProfessionalAppointment.new(appointment_params)
    # Save the object
    if @appointment.save
    # If save succeeds, redirect to the index action
      flash[:notice] = "#{t(:appointment)} #{t(:create_success)}"
      redirect_to(professional_appointments_path(@professional.id))
    else
    # If save fails, redisplay the from so user can fix problems
      render('new')
    end
  end

  def edit
    @appointment = ProfessionalAppointment.find(params[:id])
  end

  def update
    # Find and existing object using form parameters
    @appointment = ProfessionalAppointment.find(params[:id])
    # Update the object
    if @appointment.update_attributes(appointment_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "#{t(:appointment)} #{t(:update_success)}"
      redirect_to(professional_appointment_path(@professional.id, @appointment.id))
    else
      # If save fails, redisplay the from so user can fix problems
      render('edit')
    end
  end

  def delete
    @appointment = ProfessionalAppointment.find(params[:id])
  end

  def destroy
    appointment = ProfessionalAppointment.find(params[:id]).destroy
    flash[:notice] = "#{t(:appointment)} '#{appointment.date_time}' #{t(:destroy_success)}"
    redirect_to(professional_appointments_path(@professional.id))
  end

  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def appointment_params
      # same as using "params[:appointment]", except taht it:
      # - raises an error if :appointment is not present
      # - allows listed attributes to be mass-assigned
      params.require(:professional_appointment).permit(:company_id, :branch_id, :professional_id, :client_id, :shared, :needs_folloup, :date_time, :status, :task_type, :task_note, :total_project_price, :task_payment, :professional_fee, :remaining_project_payment)
    end

    def find_professional
      if params[:professional_id]
        @professional = Professional.find(params[:professional_id])
      end
    end
end
