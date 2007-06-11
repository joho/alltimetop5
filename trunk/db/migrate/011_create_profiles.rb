class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.column :user_id, :integer
      t.column :fullname, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :profiles
  end
end
