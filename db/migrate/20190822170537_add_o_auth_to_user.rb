class AddOAuthToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uid, :string
    add_column :users, :handle, :string
    add_column :users, :token, :string
  end
end
