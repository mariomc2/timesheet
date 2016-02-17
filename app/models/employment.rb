class Employment < ActiveRecord::Base
	belongs_to :professional
	belongs_to :company

	validates_presence_of :professional_id, :company_id
end
