# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def self.tidy_error_messages(model, included_model_names)
    new_errors = ActiveRecord::Errors.new(nil)

    model.errors.each do |key, message|
      new_errors.add(key, message) unless included_model_names.include? key
    end

    # re-jig the errors for the included models
    for included_model_name in included_model_names
      for included_model in model.send(included_model_name)
        included_model.errors.each do |key, message|
          # use a custom error message if the model supports it
          if included_model.respond_to? :create_error_message
            included_model.create_error_message(new_errors, key, message)
          else
            new_errors.add(included_model_name, "#{key} #{message}")
          end
        end
      end
    end

    # wipe out the old errors and chuck the new ones in
    model.errors.clear
    new_errors.each do |key, message|
      model.errors.add key, message
    end
  end
  
  def truncate(string, len = 80, endstring = '&#8230;')
    if string and string.length > len and (add = string[len..-1].index(' '))
      return string[0, len + add] + endstring
    end
    string
  end 
end
