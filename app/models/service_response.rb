class ServiceResponse < ActiveRecord::Base
  attr_accessible :service_request_id

  belongs_to :service_request
  belongs_to :volunteer

  def self.response_to_request_by(service_request, volunteer)
  	where(service_request_id: service_request, volunteer_id: volunteer)
  end

  def self.responses_to_request(service_request)
  	where(service_request_id: service_request)
  end

end
