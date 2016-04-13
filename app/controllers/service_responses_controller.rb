class ServiceResponsesController < ApplicationController

  before_filter :signed_in_user
  before_filter :is_volunteer, except: [:index]

  def build
  	@service_response = current_user.volunteer.service_responses.build(service_request_id: params[:service_request_id])
    create
  end

  def create
    @service_response.save
    redirect_to service_requests_path
  end

  def destroy
    response_to_del = ServiceResponse.response_to_request_by(params[:service_request_id], current_user.volunteer)
    response_to_del.destroy_all
    redirect_to service_requests_path
  end

  def index
    @service_request = ServiceRequest.find(params[:service_request_id])
    if(@service_request.num_responses > 0)
      @service_responses = ServiceResponse.responses_to_request(params[:service_request_id]).paginate(page: params[:page])
    end
  end

  private
  	def is_volunteer
    	redirect_to root_url if !current_user.is_volunteer
    end
end
