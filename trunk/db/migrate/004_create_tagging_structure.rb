class CreateTaggingStructure < ActiveRecord::Migration
  def self.up
    create_table :lists_tags do |t|
      t.column :list_id, :integer
      t.column :tag_id, :integer
    end
    
    create_table :tags do |t|
      t.column :name, :string
    end
  end

  def self.down
    drop_table :lists_tags
    drop_table :tags
  end
end
