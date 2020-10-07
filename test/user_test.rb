require_relative 'test_helper'
require_relative '../lib/user'

describe "User" do
  describe "self.get" do
    it "returns list of users" do
      response = {}
      vcr.use_cassette("user_list") do
        response = User.get('https://slack.com/api/users.list')
      end
      expect(response).must_be_kind_of HTTParty::Response
      expect(response["ok"]).must_equal true
    end
    it "raise an error when it fails to response(bad url/api)" do
      vcr.use_cassette("user_list") do
        expect{User.get('https://slack.com/api/users')}.must_raise SlackError
      end
    end
    describe "self.list_all" do
      it "returns a list of users" do
        users = []
        vcr.use_cassette("user_list") do
          users = User.list_all
        end
        expect(users).must_be_kind_of Array #the users were set to an array in the test (line 21), it will always return passing.
      end
    end
  end
end




# describe "Slack ser class" do
#   before do
#     @user = User.new(
#         name: "Fakester",
#         slack_id: "10AB45FRE",
#         real_name:"Fakey McFaker",
#         status_text: "helllloooo",
#         status_emoji: ":sunrise:"
#     )
#   end
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