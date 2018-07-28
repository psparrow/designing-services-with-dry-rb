require_relative './service'

URL = 'foo'

class NotifySlack < Service
  Schema = Dry::Validation.Schema do
    required(:message).filled
  end

  option :message
  option :notifier, default: -> { Slack::Notifier.new(URL) }
  
  def call
    notifier.ping(message)
  end
end