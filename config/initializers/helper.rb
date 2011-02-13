class Helper
  
  def self.truncate(text, options = {})
    options.reverse_merge!(:length => 30)
    text.truncate(options.delete(:length), options) if text
  end
  
end