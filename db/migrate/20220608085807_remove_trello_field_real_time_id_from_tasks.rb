class RemoveTrelloFieldRealTimeIdFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :trello_field_real_time_id, :integer
  end
end
