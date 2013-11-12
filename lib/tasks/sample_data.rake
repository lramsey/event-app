namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_events
    make_relationships
  end
end

def make_users
  admin = User.create!(name: "Example User",
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
end

def make_events
  users = User.all(limit: 12)
  15.times do
    details  = Faker::Lorem.paragraph[0..45]
    start    = Time.now + rand(6).days
    finish   = start + rand(2).days
    where = "Los Angeles"
    users.each { |user| user.events.create!(details: details, start: start, 
                                            finish: finish, where: where) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end