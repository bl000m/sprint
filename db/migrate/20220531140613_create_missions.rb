class CreateMissions < ActiveRecord::Migration[6.1]
  def change
    create_table :missions do |t|
      t.time :start_at
      t.time :end_at
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
