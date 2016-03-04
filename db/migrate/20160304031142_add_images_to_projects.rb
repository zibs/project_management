class AddImagesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :images, :text, array:true, default: []  
  end
end
