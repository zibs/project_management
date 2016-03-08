class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :due_date, :project_leader
  has_many :tasks
  has_many :discussions
  

  def project_leader
    User.find(self.object.user_id).full_name
    # binding.pry
    # User.find(user_id).full_name if user_id
  end

end
