FactoryGirl.define do
  factory :user do
    sequence(:first_name)  { |n| "Fname #{n}" }
    sequence(:last_name)  { |n| "Lname #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    contact_no "4683748378"
    gender "M"
    city "Chennai"
    password "foobar"
    password_confirmation "foobar"

    factory :volunteer_set do
      is_volunteer true
    end
  end


  factory :volunteer do
    languages_known ["English", "Tamil", "Hindi"]
    availability 127
    user
  end

  factory :service_request do
    date Date.today + 5
    city "Chennai"
    language "English"
    start_time "10:00 AM"
    end_time "11:00 AM"
    user

    factory :closed_request
      date Date.today - 1
    end
  end

end