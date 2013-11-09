namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    users = User.all(limit: 12)
    15.times do
      details  = Faker::Lorem.sentence(5)
      start    = Time.now + rand(6).days
      finish   = start + rand(2).days
      where = "Los Angeles"
      users.each { |user| user.events.create!(details: details, start: start, 
                                              finish: finish, where: where) }
    end
  end
end