class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.column  :title, :string,  :null => false
      t.column  :user_id, :integer, :null => false
      
      t.column  :created_at,  :timestamp
      t.column  :updated_at,  :timestamp
    end
  end
  
  def self.down
    drop_table :lists
  end
end