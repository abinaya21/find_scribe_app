require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }

  let(:student) { FactoryGirl.create(:user) }

  describe "Signin page" do

    before do
      visit signin_path
      fill_in "Name",             with: student.email
      fill_in "Password",         with: student.password
      click_button "Sign in"
    end

    it { should_not have_selector('div.alert.alert-error') }
  end
  
end
