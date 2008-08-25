class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  
  validates_presence_of :text
  validates_presence_of :user_id
  validates_presence_of :list_id
end
