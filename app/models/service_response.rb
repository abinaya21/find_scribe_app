class ServiceResponse < ActiveRecord::Base
  attr_accessible :service_request_id

  belongs_to :service_request
  belongs_to :volunteer

  after_create :increment_responses_count
  before_destroy :decrement_responses_count

  def self.response_to_request_by(service_request, volunteer)
  	where(service_request_id: service_request, volunteer_id: volunteer)
  end

  def self.responses_to_request(service_request)
  	where(service_request_id: service_request)
  end

  def increment_responses_count
  	if(!self.service_request.nil?)
  		self.service_request.num_responses = self.service_request.num_responses + 1
  		self.service_request.save
  	end
  end

  def decrement_responses_count
  	if(!self.service_request.nil?)
  		self.service_request.num_responses = self.service_request.num_responses - 1
  		self.service_request.save
  	end
  end

end
