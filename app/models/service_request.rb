class ServiceRequest < ActiveRecord::Base
  attr_accessible :city, :date, :language, :start_time, :end_time

  belongs_to :user
  has_many :service_responses, dependent: :destroy
  has_many :volunteers, through: :service_responses

  validates :city, presence: true, inclusion: { in: %w(Chennai Delhi Mumbai),
    message: "Language: %{value} is not a valid option" }
  validates :date, presence: true
  validates :language, presence: true, inclusion: { in: %w(English Hindi Tamil),
    message: "Language: %{value} is not a valid option" }

  def responded_by(volunteer)
  	self.volunteers.include?(volunteer)
  end

end
