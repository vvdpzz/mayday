class Notification < ActiveRecord::Base
  belongs_to :user
  
  def self.deliver(user, dude, did_what, able)
    able_to_s = able.class.to_s
    able_id = able.id
    
    if able_to_s == "Answer"
      able_to_s = "Question"
      able_id = able.question.id
    end
    
    not_the_same_man = user.id != dude.id
    
    have_not_did_the_same_thing = !user.notifications.where(
                                    :dude_id => dude.id, :did_what => did_what, :able => able_to_s, :able_id => able_id
                                  ).present?
    
    if not_the_same_man and have_not_did_the_same_thing
      user.notifications.create(
        :dude => dude.name,
        :dude_id => dude.id,
        :did_what => did_what,
        :able => able_to_s,
        :able_id => able_id,
        :excerpt => Helper.truncate(able.excerpt)
      )
    end
  end
  
  def read?
    self.status ? true : false
  end
  
end
