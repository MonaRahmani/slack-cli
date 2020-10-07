require 'httparty'
require 'dotenv'
require 'table_print'
# require_relative 'slack'
require_relative 'channel'
require_relative 'user'
# require_relative 'recipient'

Dotenv.load


class Workspace

    attr_reader :users, :channels, :selected

    def initialize
      response = HTTParty.get('https://slack.com/api/conversations.list', query: {token: ENV['SLACK_TOKEN']})
      @users = user.list_all
      @channels = channel.list_all
    end

    def select_channel
      @channels.each do |channel|

      end

    end

    def select_user(id)
      user_array = @users.find do |user|
        user.slack_id = id
      end
      return user_array
    end


    def show_details
      # will call the details method of the previously selected user or channel
    end

    def send_message

    end
end
