
require 'spec_helper'

describe Volunteer do
  before do
    @user = FactoryGirl.create(:volunteer_set)
    @volunteer = @user.build_volunteer(languages_known: ["English", "Tamil"], available_on_sat: true, available_on_sun: true)
  end

  subject { @volunteer }

  it { should respond_to(:languages_known) }
  it { should respond_to(:available_on_sun) }
  it { should respond_to(:available_on_mon) }
  it { should respond_to(:available_on_tue) }
  it { should respond_to(:available_on_wed) }
  it { should respond_to(:available_on_thu) }
  it { should respond_to(:available_on_fri) }
  it { should respond_to(:available_on_sat) }
  it { should respond_to(:user) }
  it { should respond_to(:service_responses) }
  it { should be_valid }

end