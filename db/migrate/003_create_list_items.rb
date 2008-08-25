class CreateListItems < ActiveRecord::Migration
  def self.up
    create_table :list_items do |t|
      t.column  :title,   :string,  :null => false
      t.column  :comment, :text,  :null => false
      t.column  :rank,    :integer, :null => false
      t.column  :list_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :list_items
  end
end
