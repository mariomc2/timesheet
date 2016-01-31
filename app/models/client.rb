class Client < ActiveRecord::Base
	has_many :contact_details
	belongs_to :company
	belongs_to :branch
	has_many :company_appointments
	has_many :professional_appointments
	has_and_belongs_to_many :professionals
end
