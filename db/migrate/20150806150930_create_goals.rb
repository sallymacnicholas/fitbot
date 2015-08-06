class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.datetime :awake_time
      t.datetime :sleep_time
      t.integer :steps
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
