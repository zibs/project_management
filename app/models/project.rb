class Project < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 5 }
  # add datetime validation
end
