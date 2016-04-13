require 'spec_helper'

describe ServiceResponse do
  let(:user) { FactoryGirl.create(:volunteer_set) }
  let(:volunteer) { FactoryGirl.create(:volunteer, user: user) }
  let(:service_request) { FactoryGirl.create(:service_request) }

  before do
    @service_response = volunteer.service_responses.create(service_request_id: service_request.id)
  end

  subject { @service_response }

  it { should respond_to(:volunteer) }
  it { should respond_to(:service_request) }
  it { should be_valid }

  describe "update response count on service request" do
    before { @service_request = ServiceRequest.find(service_request.id) }
    subject { @service_request }
    its(:num_responses) { should == 1 }
  end

end