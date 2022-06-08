class AddFieldsToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :trello_field_estimated_time_id, :string
    add_column :tasks, :trello_field_real_time_id, :string
  end
end
