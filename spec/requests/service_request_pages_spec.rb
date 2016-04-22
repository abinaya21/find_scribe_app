require 'spec_helper'

describe "ServiceRequestPages" do
  subject { page }

  let(:student) { FactoryGirl.create(:user) }

  describe "New Service Request page" do

    before do
      sign_in student
      visit new_service_request_path
      fill_in "Date of Examination", with: Date.today
      fill_in "Start Time", with: "10:00 AM"
      fill_in "End Time", with: "11:00 AM"
      fill_in "Language", with: "English"
      fill_in "Location", with: "Chennai"
      click_button "Submit"
    end

    expect { click_button submit }.to change(ServiceRequest, :count).by(1)

  end

  describe "Service Request Index page for Student" do
  	before do
  		let(:volunteer_user) { FactoryGirl.create(:volunteer_set) }
  		let(:volunteer) { FactoryGirl.create(:volunteer, user: volunteer_user) }
  		let (:open_request) { FactoryGirl.create(:service_request, user: student) }
  		let (:closed_request) { FactoryGirl.create(:closed_request, user: student) }
  		let (:confirmed_request) { FactoryGirl.create(:service_request, user: student) }
  		volunteer.service_responses.create(service_request_id: confirmed_request.id)
  		sign_in student
  	end

  	describe "All Requests page" do
  		before { visit service_requests_path(filter: "All") }

  		it { should have_selector("td", text: "Req ##{open_request.id}") }
  		it { should have_selector("td", text: "Req ##{closed_request.id}") }
  		it { should have_selector("td", text: "Req ##{confirmed_request.id}") }
  	end

  	describe "Open Requests page" do
  		before { visit service_requests_path(filter: "Open") }

  		it { should have_selector("td", text: "Req ##{open_request.id}") }
  		it { should_not have_selector("td", text: "Req ##{closed_request.id}") }
  		it { should_not have_selector("td", text: "Req ##{confirmed_request.id}") }
  	end

  	describe "Confirmed Requests page" do
  		before { visit service_requests_path(filter: "Confirmed") }

  		it { should_not have_selector("td", text: "Req ##{open_request.id}") }
  		it { should_not have_selector("td", text: "Req ##{closed_request.id}") }
  		it { should have_selector("td", text: "Req ##{confirmed_request.id}") }
  	end

  	describe "Closed Requests page" do
  		before { visit service_requests_path(filter: "Closed") }

  		it { should_not have_selector("td", text: "Req ##{open_request.id}") }
  		it { should have_selector("td", text: "Req ##{closed_request.id}") }
  		it { should_not have_selector("td", text: "Req ##{confirmed_request.id}") }
  	end

  end

  describe "Edit Service Request page" do
  	before do
  		let(:volunteer_user) { FactoryGirl.create(:volunteer_set) }
  		let(:volunteer) { FactoryGirl.create(:volunteer, user: volunteer_user) }
  		let (:confirmed_request) { FactoryGirl.create(:service_request, user: student) }
  		volunteer.service_responses.create(service_request_id: confirmed_request.id)
  		sign_in student
  		visit edit_service_request_path(confirmed_request.id)
  	end

  	expect { click_button submit }.to change(ServiceRequest.find(confirmed_request.id).num_responses, :count).by(-1)

  end

  describe "Service Request Index page for Volunteer" do
  	before do
  		let(:volunteer_user) { FactoryGirl.create(:volunteer_set) }
  		let(:volunteer) { FactoryGirl.create(:volunteer, user: volunteer_user) }
  		let (:open_request) { FactoryGirl.create(:service_request, user: student) }
  		let (:closed_request) { FactoryGirl.create(:closed_request, user: student) }
  		let (:confirmed_request) { FactoryGirl.create(:service_request, user: student) }
  		volunteer.service_responses.create(service_request_id: confirmed_request.id)
  		sign_in volunteer
  	end

  	describe "All Requests page" do
  		before { visit service_requests_path(filter: "All") }

  		it { should have_selector("td", text: "Req ##{open_request.id}") }
  		it { should have_selector("td", text: "Req ##{closed_request.id}") }
  		it { should have_selector("td", text: "Req ##{confirmed_request.id}") }
  	end

  	describe "Open Requests page" do
  		before { visit service_requests_path(filter: "Open") }

  		it { should have_selector("td", text: "Req ##{open_request.id}") }
  		it { should_not have_selector("td", text: "Req ##{closed_request.id}") }
  		it { should_not have_selector("td", text: "Req ##{confirmed_request.id}") }
  	end

  	describe "Confirmed Requests page" do
  		before { visit service_requests_path(filter: "Confirmed") }

  		it { should_not have_selector("td", text: "Req ##{open_request.id}") }
  		it { should_not have_selector("td", text: "Req ##{closed_request.id}") }
  		it { should have_selector("td", text: "Req ##{confirmed_request.id}") }
  	end

  	describe "Closed Requests page" do
  		before { visit service_requests_path(filter: "Closed") }

  		it { should_not have_selector("td", text: "Req ##{open_request.id}") }
  		it { should have_selector("td", text: "Req ##{closed_request.id}") }
  		it { should_not have_selector("td", text: "Req ##{confirmed_request.id}") }
  	end

  	describe "Confirm Availability" do
  		before { visit service_requests_path }
  	end

  end

end
