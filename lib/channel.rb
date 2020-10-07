require 'httparty'
require 'dotenv'
require 'table_print'
require_relative 'workspace'
require_relative 'slack'
require_relative 'user'
require_relative 'recipient'

Dotenv.load
# needs to be child of recipient
# attributes: topic, member_count
# methods: details, self.list_all
module Slack

  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(name:, slack_id:, topic:, member_count:)
      super(slack_id: slack_id, name: name)
      @topic = topic
      @member_count = member_count
    end

    def details
      #prints info for currently selected channel, if not, should let user know and return to main command prompt
    end

    def self.list_all

      responce = self.get('https://slack.com/api/conversations.list', query: {token: ENV['SLACK_TOKEN']})

      channels = []
      responce["channels"].each do |channel|
        new_channel = self.new(
            name: channel["name"],
            slack_id: channel["id"],
            topic: channel["topic"]["value"],
            member_count: channel["num_members"]

        )
        channels << new_channel
        Workspace.add_channel(new_channel)
      end
      return channels
    end

  end
end

