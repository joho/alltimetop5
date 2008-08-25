class Fixtags < ActiveRecord::Migration
  def self.up
    drop_table :lists_tags
    
    create_table :lists_tags, :id => false do |t|
      t.column :list_id, :integer, :null => false
      t.column :tag_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :friendships
  end
end
