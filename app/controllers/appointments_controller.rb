class AppointmentsController < ApplicationController
  
  layout "professional"

  before_action :set_locale
  before_action :current_user

  def index
    if params[:company_id]
      @appointments = @current_user.appointments.where(company_id: params[:company_id])
    elsif params[:professional_id]
      @appointments = @current_user.appointments.where(professional_id: params[:professional_id])        
    else
      @appointments = @current_user.appointments
    end    
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    begin
      @appointment = @current_user.appointments.new({:date_time => Time.zone.now})
    rescue Exception => e # Catch exceptions 
      flash[:notice] = e.to_s
      redirect_to([@current_user, :appointments])
    end
  end

  def create
    # Instantiate a new object using form parameters
    @appointment = Appointment.create(appointment_params)
    if @appointment.save
      begin
        @current_user.appointments << @appointment
        
        # If save succeeds, redirect to the index action
        flash[:notice] = "#{t(:appointment)} #{t(:create_success)}"        
      rescue Exception => e # Catch exceptions if it can't create the children of a company
        # If there is an exception delete the objects created and redirect to index
        if @appointment then @appointment.destroy end

        flash[:notice] = "#{t(:appointment)}->" + e.to_s
        redirect_to([@current_user, :appointments]) 
      end   
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
      redirect_to([@current_user, @appointment])
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
    redirect_to([@current_user, :appointments])
  end

  private

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def appointment_params
      # same as using "params[:appointment]", except taht it:
      # - raises an error if :appointment is not present
      # - allows listed attributes to be mass-assigned
      params.require(:appointment).permit(:id_token, :company_id, :branch_id, :professional_id, :client_id, :shared, :needs_folloup, :date_time, :status, :task_type, :task_note, :total_project_price, :task_payment, :remaining_project_payment, :time_zone)
    end
end
