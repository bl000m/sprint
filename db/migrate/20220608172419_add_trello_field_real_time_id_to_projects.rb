class AddTrelloFieldRealTimeIdToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :trello_field_real_time_id, :string
  end
end
