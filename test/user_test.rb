require_relative 'test_helper'
require_relative '../lib/user'
require_relative '../lib/recipient'

describe "User" do
  describe "instance of the class User" do
    before do
      @user = User.new(
          name: "SlackBot",
          slack_id: "10AB45FRE",
          real_name:"Fakey McFaker",
          status_text: "helllloooo",
          status_emoji: ":sunrise:"
      )
    end
    describe "User instantiation" do
      it "creates instance of User" do
        expect(@user).must_be_kind_of User
      end

      it "attribute of the instance" do
        expect(@user.name).must_be_kind_of String
        expect(@user.slack_id).must_be_kind_of String
        expect(@user.real_name).must_be_kind_of String
        expect(@user.status_text).must_be_kind_of String
        expect(@user.status_emoji).must_be_kind_of String
      end
    end

    describe "get_users" do
      it "gets all the slack users" do
        VCR.use_cassette("channels_list")
        response = channel.get(
            'https://slack.com/api/users.list',
            query: {token: ENV['SLACK_TOKEN']}
        )
        expect(response["members"]).must_be_kind_of Array
        expect(response.code).must_equal 200
        expect(response["ok"]).must_equal true
      end
    end

    it "will raise an exception if the search fails" do
      VCR.use_cassette("users_find") do
        expect {
          user.get(
              'https://slack.com/api/ust',
              query: {token: ENV['SLACK_TOKEN']}
          )
        }.must_raise SearchError
      end
    end





  end
end




# describe "Slack ser class" do

#
#   describe "User instantiation" do
#     it 'is an instance of user' do
#       expect(@user).must_be_kind_of Slack::User
#     end
#
#     it 'sets users to an array' do
#       expect(@user.list_all).must_be_kind_of Array
#     end
#   end
# end