class Adddraftstatus < ActiveRecord::Migration
  def self.up
    add_column :lists, :published, :boolean, :default => true
  end

  def self.down
    drop_column :lists, :published
  end
end
