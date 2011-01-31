class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  validates_presence_of :body, :message => "can't be blank"
  validates_length_of :body, :minimum => 15
  
  validate :afford_to_pay_answer, :on => :create
  
  def rendering
    body_markdown = BlueCloth.new(self.body).to_html
    self.body_markdown = body_markdown
    self.excerpt = truncate(body_markdown.gsub(/<\/?[^>]*>/,  ''), :length => 140)
  end
  
  def afford_to_pay_answer
    errors.add_to_base("You do not have enough money to pay, please recharge.") if self.user.money < APP_CONFIG['answer_charge'].to_i
  end
  
  def truncate(text, options = {})
    options.reverse_merge!(:length => 30)
    text.truncate(options.delete(:length), options) if text
  end
end
