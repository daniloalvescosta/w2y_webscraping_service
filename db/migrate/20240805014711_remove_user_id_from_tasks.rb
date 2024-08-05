class RemoveUserIdFromTasks < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :user_id, :string
  end
end
