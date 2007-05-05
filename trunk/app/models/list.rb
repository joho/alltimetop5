class List < ActiveRecord::Base
  has_many :list_items
  belongs_to :user
  
  validates_presence_of :title
  validates_presence_of :user_id, :message => 'must be logged in to save a list'
  
  def email(email_address)
    raise "send a fucking email"
  end
end
