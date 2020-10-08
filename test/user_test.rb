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

    describe 'self.get' do
      it 'returns list of users' do
        response = {}
        VCR.use_cassette('user_list') do
          response = User.get('https://slack.com/api/users.list', {token: ENV['SLACK_TOKEN']})
        end
        expect(response).must_be_kind_of HTTParty::Response
        expect(response['ok']).must_equal true
      end

      it 'raise an error when it fails to response(bad url/api)' do
        VCR.use_cassette('user_list') do
          expect { User.get('https://slack.com/api/users')}.must_raise SlackError
        end
      end
      describe 'self.list_all' do
        it 'returns a list of users' do
          VCR.use_cassette('user_list') do
            response = User.get('https://slack.com/api/users.list', {token: ENV['SLACK_TOKEN']})
            expect { response }.must_be_kind_of Array
          end
        end
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