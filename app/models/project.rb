class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  mount_uploaders :images, ImagesUploader

  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :comments, through: :discussions

  has_many :favourites, dependent: :destroy
  has_many :favouriting_users, through: :favourites, source: :user

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 5 }
  validate  :future_due_date



  def favourite_for(user)
    favourites.find_by(user_id: user)
  end


  private

    def future_due_date
      if self.due_date
       self.due_date > Date.yesterday ? true : errors.add(:due_date, "must be in the future!")
      end
    end
end
