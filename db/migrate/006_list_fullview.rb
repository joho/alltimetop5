class ListFullview < ActiveRecord::Migration
  def self.up
    add_column :lists, :fullviews, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :lists, :fullviews
  end
end
