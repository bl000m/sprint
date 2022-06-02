class AddFieldsdToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :trello_board_id, :integer
    add_column :projects, :trello_list_id, :integer
  end
end
