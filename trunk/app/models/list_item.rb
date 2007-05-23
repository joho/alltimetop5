class ListItem < ActiveRecord::Base
  belongs_to :list
  
  # validates_presence_of :list_id
  
  validates_presence_of :title
  
  def create_error_message(error_array, error_key, error_value)
    error_array.add("List entry #{rank}", "#{error_key} #{error_value}")
  end
  
  def <=>(other)
    # When sorting list items they should be ordererd on rank
    self.rank <=> other.rank
  end
end
