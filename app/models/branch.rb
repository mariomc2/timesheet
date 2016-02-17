class Branch < ActiveRecord::Base
	has_many :contact_details
	belongs_to :company
	has_many :clients
	has_many :appointments

	validates_presence_of :company_id
end
