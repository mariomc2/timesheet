class Appointment < ActiveRecord::Base
	belongs_to :company
	belongs_to :branch
	belongs_to :professional
	belongs_to :client

	validates_presence_of :company_id, :branch_id, :professional_id, :client_id

	after_initialize :generate_token, :if => :new_record?

	private
		MAX_RETRIES = 3
		# generate a unique token id for new records
		def generate_token
			self.id_token ||= SecureRandom.hex(4) 
			if Appointment.exists?(:id_token => id_token)
				self.id_token = nil
				raise
			end			
		rescue Exception => e
			@token_attempts = @token_attempts.to_i + 1
			puts "Record not unique " + @token_attempts.to_s
			retry if @token_attempts < MAX_RETRIES
			raise e, "#{I18n.t(:professional)}: #{I18n.t(:create_unsuccess)} #{I18n.t(:uniqueness_unsuccess)}"
		end

end
