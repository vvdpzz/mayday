module BrainstormsHelper
  
  def editable_by_brainstorm(obj)
    link_to('Edit', [:edit, obj])
  end
  
  def deletable(obj)
    link_to 'Destroy', obj, :confirm => 'Are you sure?', :method => :delete
  end
  
  def links_for_brainstorm(obj)
    [editable_by_brainstorm(obj), deletable(obj), timestamp(obj)].compact.join(delimitor).to_s.html_safe
  end
  
end
