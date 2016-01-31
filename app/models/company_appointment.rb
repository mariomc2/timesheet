class CompanyAppointment < ActiveRecord::Base
	belongs_to :company
	belongs_to :branch
	belongs_to :professional
	belongs_to :client

	belongs_to :professional_appointment
end
