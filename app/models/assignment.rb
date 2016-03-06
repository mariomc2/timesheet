class Assignment < ActiveRecord::Base
	belongs_to :professional
	belongs_to :appointment

	validates_presence_of :professional_id, :appointment_id
end
