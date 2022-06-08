class RemoveTrelloFieldEstimatedTimeIdFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :trello_field_estimated_time_id, :integer
  end
end
