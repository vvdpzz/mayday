module ActsAsTaggableOn
  class TagList < Array
    def self.from(string)
      
      string.gsub!(/，([\s])+/,',')
      
      glue   = delimiter.ends_with?(" ") ? delimiter : "#{delimiter} "
      string = string.join(glue) if string.respond_to?(:join)

      new.tap do |tag_list|
        string = string.to_s.dup

        # Parse the quoted tags
        string.gsub!(/(\A|#{delimiter})\s*"(.*?)"\s*(#{delimiter}\s*|\z)/) { tag_list << $2; $3 }
        string.gsub!(/(\A|#{delimiter})\s*'(.*?)'\s*(#{delimiter}\s*|\z)/) { tag_list << $2; $3 }

        tag_list.add(string.split(delimiter))
      end
    end
  end
end