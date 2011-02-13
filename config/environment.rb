# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mayday::Application.initialize!

# ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)
# ActiveMerchant::Billing::Integrations::Alipay::KEY = 
# ActiveMerchant::Billing::Integrations::Alipay::ACCOUNT = 
# ActiveMerchant::Billing::Integrations::Alipay::EMAIL = 
