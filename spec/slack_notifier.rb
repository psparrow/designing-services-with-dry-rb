module Slack
  class SlackError < StandardError; end
  class Notifier
    def initialize(*args); end

    def ping(_message)
      'sent'
    end
  end
end
