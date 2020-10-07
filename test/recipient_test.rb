
require_relative 'test_helper'

describe Slack::Recipient do
  describe self.list_all do
    it 'raises an error if invoked directly (without subclassing' do
      expect{ Slack::Recipient.list_all }.must_raise ArgumentError
    end
  end
end