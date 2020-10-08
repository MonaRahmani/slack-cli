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
          topic:"test",
          member_count: "12"
      )
    end

    describe "initializer" do
      it "creates instance of channel" do
        expect(@channel).must_be_kind_of Channel
      end
      it "attribute of the instance" do
        expect(@channel.slack_id).must_be_kind_of String
        expect(@channel.name).must_be_kind_of String
        expect(@channel.topic).must_be_kind_of String
        expect(@channel.member_count).must_be_kind_of String
      end
    end
  end

  describe "get_channels" do
    it "gets all the slack channel" do
      VCR.use_cassette("channels_list")
      response = channel.get(
          'https://slack.com/api/conversations.list',
          query: {token: ENV['SLACK_TOKEN']}
      )
      expect(response["channels"]).must_be_kind_of Array
      expect(response.code).must_equal 200
      expect(response["ok"]).must_equal true
    end
  end

  it "will raise an exception if the search fails" do
    VCR.use_cassette("channel_find") do
      expect {
        channel.get(
            'https://slack.com/api/conversations.list',
            query: {token: ENV['SLACK_TOKEN']}
        )
      }.must_raise SearchError
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
