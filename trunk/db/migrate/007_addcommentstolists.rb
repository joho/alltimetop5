class Addcommentstolists < ActiveRecord::Migration
  def self.up
    add_column :lists, :comment, :text
  end

  def self.down
    remove_column :lists, :comment
  end
end
