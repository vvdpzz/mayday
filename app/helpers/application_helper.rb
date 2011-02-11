module ApplicationHelper
  
  def safe_html(text)
    sanitize text, :tags => %w(h1 h2 h3 h4 h5 h6 p a b strong em pre img br table th tr td ol ul li),
                   :attributes => %w(href src width height)
  end
  
  def delimitor
    content_tag(:span, ' · ', :class => 'bullet')
  end
  
  def timestamp(obj)
    content_tag(:span, 'Created ' + time_ago_in_words(obj.created_at) + ' ago', :class => 'timestamp')
  end
  
  def tags(question)
    content_tag(:span, question.tag_list.map{|tag| link_to(tag, tagged_url(:tag => tag), :class => 'tag')}.to_sentence.html_safe, :class => 'tags').html_safe
  end
  
  def question_links(question)
    [tags(question), timestamp(question)].compact.join(delimitor).to_s.html_safe
  end
  
end
