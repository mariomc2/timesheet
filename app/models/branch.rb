class Branch < ActiveRecord::Base
	has_many :contact_details
	belongs_to :company
	has_many :clients
	has_many :company_appointments
	has_many :professional_appointments
end
