require 'spec_helper'

describe ServiceRequest do
  before do
    @service_request = FactoryGirl.create(:service_request)
  end
  subject { @service_request }

  it { should respond_to(:city) }
  it { should respond_to(:date) }
  it { should respond_to(:language) }
  it { should respond_to(:start_time) }
  it { should respond_to(:end_time) }
  it { should respond_to(:num_responses) }
  it { should respond_to(:user)}
  it { should respond_to(:service_responses) }
  it { should respond_to(:volunteers) }
  it { should respond_to(:responded_by) }
  it { should be_valid }
end