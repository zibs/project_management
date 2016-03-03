FactoryGirl.define do
  factory :project do
    association :user, factory: :user
    sequence(:title){|n| "#{Faker::Hipster.words(4).join(" ")}-#{n}"}
    sequence(:description){|n| "#{Faker::Hipster.sentences(1).join}-#{n}"}
    due_date { 60.days.from_now }
  end

end
