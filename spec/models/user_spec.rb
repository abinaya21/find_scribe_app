
require 'spec_helper'

describe User do
  before { @user = FactoryGirl.create(:user) }
  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token)}
  it { should respond_to(:is_volunteer) }
  it { should respond_to(:city) }
  it { should respond_to(:gender) }
  it { should respond_to(:contact_no) }
  it { should respond_to(:dob) }
  it { should respond_to(:address) }
  it { should respond_to(:volunteer) }
  it { should respond_to(:service_requests) }
  it { should respond_to(:volunteer) }
  it { should be_valid }

end