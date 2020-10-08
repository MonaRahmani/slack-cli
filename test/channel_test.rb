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
<<<<<<< HEAD
      it 'returns list of channels' do
        VCR.use_cassette('channel_list') do
          response = Channel.get('https://slack.com/api/conversations.list', {token: ENV['SLACK_TOKEN']})
        end
      expect(response).must_be_kind_of HTTParty::Response
      expect(response['ok']).must_equal true
=======
      it 'return a list of channels' do
        response = {}
        VCR.use_cassette('channel_list') do
          response = Channel.get('https://slack.com/api/conversations.list',
                                 {token: ENV['SLACK_TOKEN']})
          expect(response).must_be_kind_of HTTParty::Response
          expect(response['ok']).must_equal true
        end
      end
>>>>>>> b25fd29b9406bf01b3ed8a6ec91808e744bbaf54
    end

    it 'raise an error when it fails to response(bad url/api)' do
      VCR.use_cassette('channel_list') do
<<<<<<< HEAD
        expect { User.get('https://slack.com/api/', {token: ENV['SLACK_TOKEN']}) }.must_raise SlackError
=======
        expect { User.get('https://slack.com/api/', {token: ENV['SLACK_TOKEN']})}.must_raise SlackAPIError
>>>>>>> b25fd29b9406bf01b3ed8a6ec91808e744bbaf54
      end
    describe 'self.list_all' do
      it 'returns a list of channel' do
        VCR.use_cassette('channel_list') do
          channels = User.list_all
          expect(channels).must_be_kind_of Array
        end
      end
    end
  end
end







