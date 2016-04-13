class ServiceRequestsController < ApplicationController

  before_filter :signed_in_user
  before_filter :is_student, except: [:index]
  before_filter :validate_date, only: [:create, :update]


  def new
  	@service_request = current_user.service_requests.build
  end

  def create
  	if @service_request.save
  		redirect_to root_url
  	else
  		render "new"
  	end
  end

  def index
    @filter_options   = [["All Requests", "All"], ["Confirmed Requests", "Responded"], ["Open Requests", "Open"]]
    @request_filter   = (params[:filter].nil?) ? "All" : params[:filter]

    retrieve_service_requests
  end

  def retrieve_service_requests

    if current_user.is_volunteer
      @service_requests = get_associated_requests(current_user, @request_filter)
    else
      @service_requests = get_submitted_requests(current_user, @request_filter)
    end

    @service_requests = @service_requests.paginate(page: params[:page])
  end

  def edit
  	@service_request = ServiceRequest.find(params[:id])
    @service_request.start_time = @service_request.start_time.to_s(:timings) unless @service_request.start_time.nil?
    @service_request.end_time = @service_request.end_time.to_s(:timings) unless @service_request.end_time.nil?
  end

  def update
    @service_request = ServiceRequest.find(params[:id])
    if(@service_request.update_attributes(params[:service_request]))
		  redirect_to service_requests_path
      @service_request.service_responses.destroy_all
    else
		  render "edit"
    end
  end

  def destroy
    @service_request = ServiceRequest.find(params[:id])
    @service_request.destroy
    redirect_to service_requests_path
  end

  private

    def validate_date
    	@service_request = current_user.service_requests.build(params[:service_request])
    	if !future_date?
    		flash.now[:error] = "Only future requests can be submitted/edited"
    		render "new"
    	end
    end 

    def future_date?
    	@service_request.date >= Date.today
    end

    # param "has_response" when set to true indicates that 
    # only requests with response must be retrieved
    def get_submitted_requests(user, filter_option = "All")
      if filter_option == "Responded"
        user.service_requests.where("num_responses > 0")
      elsif filter_option == "Open"
        user.service_requests.where("num_responses = 0")
      else
        user.service_requests
      end
    end

    def get_associated_requests(user, filter_option = "All")
      service_requests = []
      if filter_option == "Responded"
        service_requests = user.volunteer.service_requests.where("date >= CURDATE()")
      elsif filter_option == "Open"
        get_matching_requests(user).each do |request|
          if(!request.responded_by(current_user.volunteer))
            service_requests << request
          end
        end
      else
        service_requests = get_matching_requests(user)
      end
      return service_requests
    end

    def get_matching_requests(user)
      volunteer = user.volunteer;
      languages_array = ["English","Tamil"]#@volunteer.languages_known
      languages_array = "(" << languages_array.map(&:inspect).join(', ') << ")"
      city = user.city
      wday_array = get_availability_array(volunteer)
      wday_array = "(" << wday_array.join(',') << ")"
      query_string = "date >= CURDATE() AND city = '#{city}' AND language IN #{languages_array} AND DAYOFWEEK(date) IN #{wday_array}"
      service_requests = ServiceRequest.where(query_string).order('date ASC')
    end


    def get_availability_array(volunteer)
      availability = []
      availability << 1 if volunteer.available_on_sun
      availability << 2 if volunteer.available_on_mon
      availability << 3 if volunteer.available_on_tue
      availability << 4 if volunteer.available_on_wed
      availability << 5 if volunteer.available_on_thu
      availability << 6 if volunteer.available_on_fri 
      availability << 7 if volunteer.available_on_sat
    end

    def is_student
      redirect_to root_url if current_user.is_volunteer
    end

end
