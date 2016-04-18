class ServiceResponse < ActiveRecord::Base
  attr_accessible :service_request_id, :response_invalid

  belongs_to :service_request
  belongs_to :volunteer

  after_create :increment_responses_count
  after_save :update_responses_count
  before_destroy :decrement_responses_count_if_valid

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

  def decrement_responses_count_if_valid #service response deleted
    decrement_responses_count unless self.response_invalid
  end

  def update_responses_count
    if(self.response_invalid_changed?) #service response updated and response status changed
      if(self.response_invalid)
        decrement_responses_count
      else
        increment_responses_count
      end
    end
  end

end
