require 'rails_helper'

RSpec.describe Project, :type => :model do
  describe "validations" do
    it "validates the presence of the project title" do
      p = Project.new
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "validates the uniquness of the project title" do
      Project.create(title: "abc", description: "123123123")
      p = Project.create(title: "abc", description: "123123123")
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "does not validate when the due_date is in the past" do
        p = Project.new(title: "abddc",
                        description: "123123123",
                        due_date: Date.yesterday)
        p.valid?
        expect(p.errors).to have_key(:due_date)
    end

    it "validates the due_date is greater than or equal to today" do
        p = Project.new(title: "abddc",
                        description: "123123123",
                        due_date: Date.tomorrow)
        expect(p).to be_valid
    end

  end
end
