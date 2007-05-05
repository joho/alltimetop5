class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column  :username,  :string,  :null => false
      t.column  :email,     :string,  :null => false
      t.column  :hashed_password, :string,  :null => false
      
      t.column  :created_at,  :timestamp
      t.column  :updated_at,  :timestamp
    end
  end

  def self.down
    drop_table :users
  end
end
