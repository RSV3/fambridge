namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(first_name: "Example User",
                email: "example@railstutorial.org",
                password: "foobar",
                password_confirmation: "foobar",
                super_admin: true)
    99.times do |n|
      first_name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(first_name: first_name,
                    email: email,
                    password: password,
                    password_confirmation: password)
    end
  end
end