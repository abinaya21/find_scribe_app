class ServiceResponse < ActiveRecord::Base
  attr_accessible :service_request_id

  belongs_to :service_request
  belongs_to :volunteer
end
