FactoryGirl.define do
  factory :task do
    association :user, factory: :user
    association :project, factory: :project
    title { Faker::Hacker.say_something_smart }
    due_date { 5.days.from_now }
  end

end
