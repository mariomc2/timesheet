class Professional < ActiveRecord::Base
	has_many :contact_details
	has_many :assignments
	has_many :appointments, :through => :assignments
	has_and_belongs_to_many :clients
	has_many :employments
	has_many :companies, :through => :employments

	validates_presence_of :first_name

	scope :sorted_name, lambda { order("professionals.first_name ASC")}
	scope :sorted_Lastname, lambda { order("professionals.last_name ASC")}
  scope :newest_first, lambda { order("professionals.created_at DESC")}
  scope :search, lambda {|query|
    where(["name LIKE ?", "%#{query}%"])
  }

  after_initialize :generate_token, :if => :new_record?

	private
		MAX_RETRIES = 3
		# generate a unique token id for new records
		def generate_token
			self.id_token ||= SecureRandom.hex(8) 
			if Professional.exists?(:id_token => id_token)
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
