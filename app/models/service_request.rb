class ServiceRequest < ActiveRecord::Base
  attr_accessible :city, :date, :language, :start_time, :end_time, :num_responses

  belongs_to :user
  has_many :service_responses, dependent: :destroy
  has_many :volunteers, through: :service_responses

  before_create :init

  validates :city, presence: true, inclusion: { in: %w(Chennai Delhi Mumbai),
    message: "%{value} is not a valid option" }
  validates :date, presence: true
  validates :language, presence: true, inclusion: { in: %w(English Hindi Tamil),
    message: "%{value} is not a valid option" }
  validates :start_time, presence: true
  validates :end_time, presence: true

  def responded_by(volunteer)
  	self.volunteers.include?(volunteer)
  end

  def init
  	self.num_responses = 0
  end

end
