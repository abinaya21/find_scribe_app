class Volunteer < ActiveRecord::Base
  attr_accessible :availability, :languages_known, :user_id

  after_initialize :init

  belongs_to :user
  has_many :service_responses, dependent: destroy
  has_many :service_requests, through: :service_responses

  validates :languages_known, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 7 }
  validates :availability, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 127 }


  def init
  	self.languages_known ||= 0
  	self.availability ||= 0
  end
end
