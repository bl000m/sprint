class AddRealTimeToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :real_time, :decimal
  end
end
