class Volunteer < ActiveRecord::Base

  attr_accessible :availability, :languages_known, :city, :available_on_sun,
                  :available_on_mon, :available_on_tue, :available_on_wed, 
                  :available_on_thu, :available_on_fri, :available_on_sat

  include FlagShihTzu

  has_flags   1 => :available_on_sun, 2 => :available_on_mon, 3 => :available_on_tue, 
              4 => :available_on_wed, 5 => :available_on_thu, 6 => :available_on_fri, 
              7 => :available_on_sat, 
              :column => "availability"

  after_initialize :init

  before_validation do |v|
    v.languages_known.reject!(&:blank?) if v.languages_known
  end

  belongs_to :user
  has_many :service_responses, dependent: :destroy
  has_many :service_requests, through: :service_responses

  validates :languages_known, presence: true
  validates :availability, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 127, 
                                          message: "not set" }


  def init
  	self.availability ||= 0
    self.languages_known ||= []
  end

end
