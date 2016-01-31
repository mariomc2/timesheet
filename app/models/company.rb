class Company < ActiveRecord::Base
	has_many :contact_details
	has_many :branches
	has_many :clients
	has_many :company_appointments
	has_many :professional_appointments
	has_many :employments
	has_many :professionals, :through => :employments
end
