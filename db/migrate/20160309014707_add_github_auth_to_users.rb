class AddGithubAuthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_token, :string
    add_column :users, :github_extra_data, :text
  end
end
