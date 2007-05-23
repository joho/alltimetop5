class List < ActiveRecord::Base
  has_many :list_items
  belongs_to :user
  
  acts_as_taggable
  
  validates_presence_of :title
  validates_presence_of :user_id, :message => 'must be logged in to save a list'
  
  def each
    # iterate over each list item within the list
    # in order of rank
    for list_item in self.list_items.sort
      yield list_item
    end
  end
end
