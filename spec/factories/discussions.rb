FactoryGirl.define do
  factory :discussion do
    association :user, factory: :user
    association :project, factory: :project
    title { Faker::Shakespeare.hamlet_quote }
    body  { Faker::Hacker.say_something_smart }
  end
end
