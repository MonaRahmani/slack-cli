# require 'httparty'
require 'dotenv'
require 'table_print'
# require_relative 'workspace'
# require_relative 'slack'
# require_relative 'user'
require_relative 'recipient'

Dotenv.load

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
      response = get(CHANNEL_LIST, query: {token: ENV['SLACK_TOKEN']})

      channels = []
      response["channels"].each do |channel|
        new_channel = new(
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


