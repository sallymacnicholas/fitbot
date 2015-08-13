class CreateProfileTable < ActiveRecord::Migration
  def change
    create_table :profile do |t|
      t.datetime :awake_time
      t.datetime :sleep_time
      t.references :user, index: true, foreign_key: true
    end
    remove_column :goals, :awake_time
    remove_column :goals, :sleep_time
  end
end
