FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :event do
    user
    details "Pizza!"
    start   Time.now + 2.days
    finish  Time.now + 3.days
    where   "Los Angeles"
  end
end