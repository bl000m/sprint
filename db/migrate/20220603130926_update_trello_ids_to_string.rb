class UpdateTrelloIdsToString < ActiveRecord::Migration[6.1]
  def change
    change_column :projects, :trello_board_id, :string
    change_column :projects, :trello_list_id, :string
    change_column :projects, :trello_done_list_id, :string

    change_column :tasks, :trello_id, :string

    change_column :users, :trello_id, :string
  end
end
