class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :title, presence: true, uniqueness: true
  validate  :future_due_date


  private

    def future_due_date
      if self.due_date
       self.due_date > Date.yesterday ? true : errors.add(:due_date, "must be in the future!")
      end
    end
end
