require_relative 'test_helper'
require_relative '../lib/channel'

describe "channel" do
  describe "self.get" do
    it "return a list of channels" do
      response = {}
      vcr.use_cassette("channel_list") do
        response = Channel.get('https://slack.com/api/conversations.list')
      end
      expect(response).must_be_kind_of HTTParty::Response
      expect(response["ok"]).must_equal true
    end
    it "raise an error when it fails to response(bad url/api)" do
      vcr.use_cassette("channel_list") do
        expect{User.get('https://slack.com/api/ch')}.must_raise SlackError
      end
    end
    describe "self.list_all" do
      it "returns a list of channels" do
        channels = []
        vcr.use_cassette("user_list") do
          channels = Channel.list_all
        end
        expect(channels).must_be_kind_of Array
      end
    end

  end
end












# describe "Channel class" do
#   before do
#     @channel = Channel.new(
#         name: "animals",
#         slack_id: "D45HG123E",
#         topic:{},
#         member_count: "12"
#     )
#   end
#
#   describe "Channel instantiation" do
#     it 'is an instance of user' do
#       expect(@channel).must_be_kind_of Slack::Channel
#     end
#
#     it 'sets users to an array' do
#       expect(@channel.list_all).must_be_kind_of Array
#     end
#   end
# end