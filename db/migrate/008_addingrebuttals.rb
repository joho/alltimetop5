class Addingrebuttals < ActiveRecord::Migration
  def self.up
    add_column :lists, :rebuts_id, :integer
  end

  def self.down
    remove_columns :lists, :rebuts_id
  end
end
