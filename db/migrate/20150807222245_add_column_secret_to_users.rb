class AddColumnSecretToUsers < ActiveRecord::Migration
  def change
    add_column :users, :secret, :string
  end
end
