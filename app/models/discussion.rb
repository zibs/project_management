  class Discussion < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: :true, uniqueness: { scope: :project_id }
  validates :body, presence: :true, uniqueness: { scope: :project_id }

end
