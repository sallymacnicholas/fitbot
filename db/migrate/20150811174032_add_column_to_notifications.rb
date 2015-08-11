class AddColumnToNotifications < ActiveRecord::Migration
  def change
    rename_column :notifications, :name, :number
    add_column :notifications, :email, :string
  end
end
