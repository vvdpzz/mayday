# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
# User.create(:name => "greedy", :email => "greedy@gmail.com", :password => "greedy", :password_confirmation => "greedy")
# User.create(:name => "vvdpzz", :email => "vvdpzz@gmail.com", :password => "vvdpzz", :password_confirmation => "vvdpzz")
records = Record.where("caption = ? AND user_id != ?", 'ask', 1)
system = User.first
system.update_attribute(:money, system.money - 100)
records.each do |record|
  user = User.find record.user_id
  system.update_attribute(:money, system.money + 10)
  Record.accounting(system, true, 10, user, system, 'ask', record.remark, 'success')
end