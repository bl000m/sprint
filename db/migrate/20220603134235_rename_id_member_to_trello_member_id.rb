class RenameIdMemberToTrelloMemberId < ActiveRecord::Migration[6.1]
  def change
    rename_column :tasks, :id_member, :trello_member_id
  end
end
