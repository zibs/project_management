class Project < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 5 }
  validate  :future_due_date
  # add datetime validation


  private

    def future_due_date
      if self.due_date
       self.due_date > Date.yesterday ? true : errors.add(:due_date, "must be in the future!")
      end
    end
end
