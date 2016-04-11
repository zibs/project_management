class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :format_date, :project_leader
  has_many :tasks
  has_many :discussions


  def project_leader
    User.find(object.user_id).full_name
    # binding.pry
    # User.find(user_id).full_name if user_id
  end

  def format_date
    object.due_date.strftime("%Y-%b-%d")
  end

end
