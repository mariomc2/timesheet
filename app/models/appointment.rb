class Appointment < ActiveRecord::Base
	belongs_to :company
	belongs_to :branch
	belongs_to :professional
	belongs_to :client

	validates_presence_of :company_id, :branch_id, :professional_id, :client_id

end
