class AddUserToMission < ActiveRecord::Migration[6.1]
  def change
    add_reference :missions, :user, null: false, foreign_key: true
  end
end
