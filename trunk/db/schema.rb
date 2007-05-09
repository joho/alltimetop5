# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 4) do

  create_table "list_items", :force => true do |t|
    t.column "title",   :string,  :default => "", :null => false
    t.column "comment", :text,    :default => "", :null => false
    t.column "rank",    :integer,                 :null => false
    t.column "list_id", :integer,                 :null => false
  end

  create_table "lists", :force => true do |t|
    t.column "title",      :string,   :default => "", :null => false
    t.column "user_id",    :integer,                  :null => false
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
  end

  create_table "lists_tags", :force => true do |t|
    t.column "list_id", :integer
    t.column "tag_id",  :integer
  end

  create_table "tags", :force => true do |t|
    t.column "name", :string
  end

  create_table "users", :force => true do |t|
    t.column "username",        :string,   :default => "", :null => false
    t.column "email",           :string,   :default => "", :null => false
    t.column "hashed_password", :string,   :default => "", :null => false
    t.column "created_at",      :datetime
    t.column "updated_at",      :datetime
  end

end
