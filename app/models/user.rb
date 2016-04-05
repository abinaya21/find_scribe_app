class User < ActiveRecord::Base
  attr_accessible :address, :city, :contact_no, :dob, 
  				:email, :first_name, :gender, :last_name, :password,
  				:password_confirmation, :volunteer?

  has_secure_password

  has_one :volunteer
  has_many :service_requests, dependent: destroy
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  after_initialize :init
  after_validation { self.errors.messages.delete(:password_digest) }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :contact_no, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


  def init
    self.volunteer? = false if self.is_volunteer.nil?
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
