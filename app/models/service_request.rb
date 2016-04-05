class ServiceRequest < ActiveRecord::Base
  attr_accessible :city, :date, :language, :start_time, :end_time

  belongs_to :user
  has_many :service_responses, dependent: destroy
  has_many :volunteers, through :service_responses

  validates :city, presence: true
  validates :date, presence: true
  validates :language, presence: true, inclusion: { in: %w(English Hindi Tamil),
    message: "Language: %{value} is not a valid option" }

end
