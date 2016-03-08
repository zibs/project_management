class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :done, :body
end
