require 'dry-validation'

class NotifySlack
  Schema = Dry::Validation.Schema do
    required(:message).filled
  end

  def self.call(message:, notifier: Slack::Notifier.new(SLACK_WEBHOOK_URL))    
    return false unless Schema.call(message: message).success?
        
    notifier.ping(message)
  end
end