class User < ActiveRecord::Base
  attr_accessible :address, :city, :contact_no, :dob, 
  				:email, :first_name, :gender, :last_name, :password,
  				:password_confirmation, :is_volunteer

  has_secure_password

  has_one :volunteer, dependent: :destroy
  has_many :service_requests, dependent: :destroy

  accepts_nested_attributes_for :volunteer
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  after_initialize :init
  after_validation { self.errors.messages.delete(:password_digest) }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :gender, inclusion: { in: %w(M F), message: "%{value} is not valid" }
  validates :city, presence: true, inclusion: { in: %w(Chennai Mumbai Delhi), message: "%{value} is not valid" }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


  def init
    self.is_volunteer = false if self.is_volunteer.nil?
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
