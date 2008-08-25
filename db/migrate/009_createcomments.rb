class Createcomments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :list_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.column :text, :text
      t.column :created_at, :timestamp
    end
  end

  def self.down
    drop_table :comments
  end
end
