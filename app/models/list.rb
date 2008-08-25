class List < ActiveRecord::Base
  has_many :list_items
  has_many :comments
  belongs_to :user
  
  has_many  :rebuttals,
            :class_name => 'List',
            :foreign_key => 'rebuts_id'
  
  belongs_to  :rebuts,
              :class_name => 'List',
              :foreign_key => 'rebuts_id'
  
  acts_as_taggable :normalizer => Proc.new { |name| name.gsub(/[^a-z0-9]+/i, '').downcase }
  
  validates_presence_of :title
  validates_presence_of :user_id, :message => 'must be logged in to save a list'
  
  def each
    # iterate over each list item within the list
    # in order of rank
    for list_item in self.list_items.sort
      yield list_item
    end
  end
  
  def log_fullview
    self.fullviews += 1
    self.save
  end
  
  def self.top5_by_fullviews
    # TODO: this could easily be cached for 15 mins or so
    self.find(:all, 
              :limit => 5,
              :order => 'lists.fullviews DESC',
              :include => [:user])
  end
  
  def self.top5_recently_created
    self.find(:all,
              :limit => 5,
              :conditions => 'lists.published = 1',
              :order => 'lists.created_at DESC',
              :include => [:user])
  end
  
  def self.featured_list
    find(:first,
          :conditions => 'lists.published = 1',
          :order => 'lists.created_at DESC',
          :include => [:user, :list_items])
  end             
  
  def self.tags_category_list
    %w(one two three four five)
  end
  
  def to_param
    "#{self.id}-top5-#{self.title.gsub(/[^a-z0-9]+/i, '-')}".chomp('-')
  end
end
