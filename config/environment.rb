# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

  
  #sendgrid account config
  ActionMailer::Base.smtp_settings = {
  :user_name => 'clberry7107',
  :password => '9398Ship',
  :domain => 'rcc-clberry7107.c9users.io',
  :address => 'smtp.sendgrid.net',
  :port => 2525,
  :authentication => :plain,
  :enable_starttls_auto => true
}
