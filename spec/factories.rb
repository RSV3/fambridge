FactoryGirl.define do
  factory :user do
    first_name "Jake"
    last_name "Johnson"
    email "jake.johnson@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end