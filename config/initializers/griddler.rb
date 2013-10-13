Griddler.configure do |config|
  config.reply_delimiter = '-- REPLY ABOVE THIS LINE --'
  config.email_service = :mandrill # :sendgrid, :cloudmailin, :postmark, :mandrill, :mailgun
end

require "#{Rails.root}/lib/email_processor.rb"
