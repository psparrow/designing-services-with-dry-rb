require_relative './service'

URL = 'foo'.freeze

class NotifySlack < Service
  Schema = Dry::Validation.Schema do
    required(:message).filled
  end

  option :message
  option :notifier, default: -> { Slack::Notifier.new(URL) }
  permissible_errors [Slack::SlackError]

  def call
    notifier.ping(message)

    Success.new(true)
  end
end
