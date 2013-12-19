namespace :db do
  desc "Fill database with sample data"

  task populate_feed: :environment do

    users = User.all(limit: 6)
    50.times do
      title = Faker::Lorem.words.join(" ")
      content = Faker::Lorem.sentence(25)
      users.each { |user| user.feeds.create!(title: title, content: content) }
    end
  end
  
end