class Client < ActiveRecord::Base
	has_many :contact_details
	belongs_to :company
	belongs_to :branch
	has_many :appointments
	has_and_belongs_to_many :professionals

	validates_presence_of :company_id, :branch_id

	after_initialize :generate_token, :if => :new_record?

	private
		MAX_RETRIES = 3
		# generate a unique token id for new records
		def generate_token
			self.id_token ||= SecureRandom.hex(8) 
			if Client.exists?(:id_token => id_token)
				self.id_token = nil
				raise
			end			
		rescue Exception => e
			@token_attempts = @token_attempts.to_i + 1
			puts "Record not unique " + @token_attempts.to_s
			retry if @token_attempts < MAX_RETRIES
			raise e, "#{I18n.t(:client)}: #{I18n.t(:create_unsuccess)} #{I18n.t(:uniqueness_unsuccess)}"
		end
end
