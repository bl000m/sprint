class AddCampiToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :trello_field_estimated_time_id, :integer
  end
end
