module Slack
  class SlackError < StandardError; end
  class Notifier     
    def initialize(*args); end     
    def ping(message); 'sent' end 
  end 
end