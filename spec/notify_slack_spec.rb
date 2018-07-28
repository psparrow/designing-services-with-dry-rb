module Slack
  class Notifier 
    def initialize(*args); end     
    def ping(message); 'sent' end 
  end 
end

SLACK_WEBHOOK_URL = '12345'

class NotifySlack
  def self.call(message:)
    notifier = Slack::Notifier.new(SLACK_WEBHOOK_URL)  
    notifier.ping(message)
  end
end

RSpec.describe NotifySlack do 
  it 'works' do 
    result = described_class.call(message: 'Hello World!')
    expect(result).to eq 'sent'    
  end
end