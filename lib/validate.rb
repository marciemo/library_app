module Validate

  def valid_input?(string)
    string.match /^[\w\s\.'-]*$/
  end




end