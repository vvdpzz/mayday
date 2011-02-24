# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
# User.create(:name => "greedy", :email => "greedy@gmail.com", :password => "greedy", :password_confirmation => "greedy")
# User.create(:name => "vvdpzz", :email => "vvdpzz@gmail.com", :password => "vvdpzz", :password_confirmation => "vvdpzz")
# records = Record.where("caption = ? AND user_id = ?", 'ask', 1)
# records.each do |record|
#   payee = record.payer_id
#   payer = record.payee_id
#   record.update_attribute(:payee_id, payee)
#   record.update_attribute(:payer_id, payer)
# end
# records = Record.where("caption = ? AND user_id != ?", 'ask', 1)
# system = User.first
# system.update_attribute(:money, system.money - 100)
# records.each do |record|
#   user = User.find record.user_id
#   system.update_attribute(:money, system.money + 10)
#   Record.accounting(system, true, 10, system, user, 'ask', record.remark, 'success')
# end

Question.all.each do |question|
  question.answers_count = question.answers.count
  if question.answers.last.present?
    answer = question.answers.last
    question.ans_user_id = answer.user.id
    question.answer_user = answer.user.name
    question.last_answer = answer.excerpt
  end
  question.topics = question.tag_list.to_s
  question.save
end
User.all.each do |user|
  user.brainstorms_count = user.brainstorms.count
  user.save
end