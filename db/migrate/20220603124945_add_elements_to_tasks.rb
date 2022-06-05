class AddElementsToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :desc, :string
    add_column :tasks, :id_member, :integer
  end
end
