require 'dry-validation'

class NotifySlack
  Schema = Dry::Validation.Schema do
    required(:message).filled
  end

  def self.call(message:)    
    return false unless Schema.call(message: message).success?
    
    notifier = Slack::Notifier.new(SLACK_WEBHOOK_URL)  
    notifier.ping(message)
  end
end