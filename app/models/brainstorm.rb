class Brainstorm < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  
  validates_presence_of :body, :message => "can't be blank"
  
  def rendering
    self.body_markdown = BlueCloth.new(self.body).to_html
  end
end
