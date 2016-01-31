class Employment < ActiveRecord::Base
	belongs_to :professional
	belongs_to :company
end
