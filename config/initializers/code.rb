# ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
#   if instance.error_message.kind_of?(Array)
#     %(#{html_tag}<span class="validation-error">#{instance.error_message.join(',')}</span>).html_safe
#   else
#     %(#{html_tag}<span class="validation-error">#{instance.error_message}</span>).html_safe
#   end
# end