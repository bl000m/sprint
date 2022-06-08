class ChangeTrelloFieldEstimatedTimeIdFromProjects < ActiveRecord::Migration[6.1]
  def change
    change_column :projects, :trello_field_estimated_time_id, :string
  end
end
