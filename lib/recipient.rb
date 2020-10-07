require 'dotenv'
require 'httparty'
require_relative 'user'
require_relative 'channel'
require_relative 'slack'

Dotenv.load
token = ENV['SLACK_TOKEN']

module Slack
  class Recipient

    USER_LIST = 'https://slack.com/api/conversations.list'
    CHANNEL_LIST = 'https://slack.com/api/users.list'

    attr_reader :slack_id, :name

    def initialize(slack_id:, name:)
      @slack_id = slack_id
      @name = name
    end

    def send_message(message)
    end


    def self.get(url, params)
      response = HTTParty.get(url, params)

      if response.code != 200
        raise SlackAPIError, "API call failed with code #{response.code} and reason #{response['reason']}"
      end
      return response
    end

    def details
      raise NotImplementedError, 'Implement me in a child class!'
    end

    def self.list_all
      raise NotImplementedError, 'Implement me in a child class!'
    end

  end
end