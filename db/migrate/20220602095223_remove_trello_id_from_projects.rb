class RemoveTrelloIdFromProjects < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :trello_id, :integer
  end
end
