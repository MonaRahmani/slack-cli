require_relative 'test_helper'
require_relative '../lib/channel'
require_relative '../lib/recipient'

describe "channel" do
  describe "instance of Channel class" do
    before do
      @channel = Channel.new(
          slack_id: "D45HG123E",
          name: "random",
          # not sure topic:{},
          topic: "test",
          member_count: "12"
      )
    end
    describe "Channel instantiation" do
      it "creates instance of Channel" do
        expect(@channel).must_be_kind_of Channel
      end
    end

    describe 'self.get' do
      it 'returns list of channels' do
        VCR.use_cassette('channel_list') do
          response = Channel.get('https://slack.com/api/conversations.list', {token: ENV['SLACK_TOKEN']})
        end
      expect(response).must_be_kind_of HTTParty::Response
      expect(response['ok']).must_equal true
    end

    it 'raise an error when it fails to response(bad url/api)' do
      VCR.use_cassette('channel_list') do
        expect { User.get('https://slack.com/api/', {token: ENV['SLACK_TOKEN']}) }.must_raise SlackError
      end
    describe 'self.list_all' do
      it 'returns a list of channel' do
        VCR.use_cassette('channel_list') do
          response = User.get('https://slack.com/api/conversations.list', {token: ENV['SLACK_TOKEN']})
          expect { response }.must_be_kind_of Array
        end
      end
    end
  end
end







