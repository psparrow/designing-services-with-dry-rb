require_relative './slack_notifier'
require_relative '../lib/notify_slack'
require 'pry'

SLACK_WEBHOOK_URL = '12345'.freeze

RSpec.describe NotifySlack do
  context 'when provided an invalid message' do
    it 'returns false' do
      result = described_class.call(message: '')

      expect(result).to be_failure
    end
  end

  context 'when provided valid arguments' do
    it 'works' do
      result = described_class.call(message: 'Hello World!')

      expect(result).to be_success
    end
  end

  context 'when a permissible error is raised' do
    let(:notifier) { double(:notifier) }

    before do
      allow(notifier).to receive(:ping).and_raise(Slack::SlackError)
    end

    it 'wraps the error in a failure object' do
      result = described_class.call(message: 'Hello World!', notifier: notifier)

      expect(result).to be_failure
    end
  end

  context 'when a non-permissible error is raised' do
    let(:notifier) { double(:notifier) }

    before do
      allow(notifier).to receive(:ping).and_raise(StandardError)
    end

    it 're-raises the error' do
      expect do
        described_class.call(message: 'Hello World!', notifier: notifier)
      end.to raise_error(StandardError)
    end
  end
end
