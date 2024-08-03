class AddTasksToVehicles < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :task, null: false, foreign_key: true
  end
end
