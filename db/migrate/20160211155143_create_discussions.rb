class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
