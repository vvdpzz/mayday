module ApplicationHelper
  def safe_html(text)
    sanitize text, :tags => %w(h1 h2 h3 h4 h5 h6 p a b strong em pre img br table th tr td ol ul li),
                   :attributes => %w(href src width height)
  end
end
