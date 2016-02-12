# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
  p = Project.create(
            title: Faker::App.name,
            description: Faker::Hacker.say_something_smart,
            due_date: Faker::Date.forward(23)
            )
    10.times do
    p.tasks.create {title: Faker::Company.bs,
                    due_date: Faker::Date.forward(5) }

    p.discussion.create do
        
    end

    end
end
  # project.save


100.times do
  task = Task.new(
        title: Faker::Company.bs,
        due_date: Faker::Date.forward(5)
        )

  task.save
end
