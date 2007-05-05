class ListItem < ActiveRecord::Base
  belongs_to :list
  
  # validates_presence_of :list_id
  
  validates_presence_of :title
  validates_presence_of :comment
  
  def create_error_message(error_array, error_key, error_value)
    error_array.add("List entry #{rank}", "#{error_key} #{error_value}")
  end
end
