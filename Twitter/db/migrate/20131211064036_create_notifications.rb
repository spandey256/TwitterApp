class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :to
      t.references :from
      t.string :note_type

      t.timestamps
    end
    add_index :notifications, :to_id
    add_index :notifications, :from_id

  end
end
