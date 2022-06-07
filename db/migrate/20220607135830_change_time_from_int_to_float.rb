class ChangeTimeFromIntToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :estimated_time, :decimal
  end
end
