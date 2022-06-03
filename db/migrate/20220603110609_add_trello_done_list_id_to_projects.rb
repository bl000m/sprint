class AddTrelloDoneListIdToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :trello_done_list_id, :integer
  end
end
