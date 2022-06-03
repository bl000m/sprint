class UpdateIdsToString < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :trello_member_id, :string
  end
end
