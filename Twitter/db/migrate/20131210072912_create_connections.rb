class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.references :follower
      t.references :following

      t.timestamps
    end
    add_index :connections, :follower_id
    add_index :connections, :following_id
  end
end
