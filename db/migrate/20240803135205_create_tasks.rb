class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :user_email
      t.string :user_id
      t.string :status

      t.timestamps
    end
  end
end
