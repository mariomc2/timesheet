class Assignment < ActiveRecord::Base
	belongs_to :professional
	belongs_to :appointment

	accepts_nested_attributes_for :professional, reject_if: :all_blank

	#validates_presence_of :professional_id, :appointment_id
end
