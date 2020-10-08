
require_relative 'recipient'


class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(name:, slack_id:, topic:, member_count:)
      super(slack_id: slack_id, name: name)
      @topic = topic
      @member_count = member_count
    end

    def details
      #prints info for currently selected channel, if not, should let user know and return to main command prompt
      detailed_info = "Slack_id: #{slack_id}, Name: #{@name}, Member Count: #{@member_count}"
      return detailed_info
    end

    def self.list_all
      response = get(CHANNEL_LIST, {token: ENV['SLACK_TOKEN']})

      channels = []
      response["channels"].each do |channel|
        new_channel = new(
            name: channel["name"],
            slack_id: channel["id"],
            topic: channel["topic"]["value"],
            member_count: channel["num_members"]

        )
        channels << new_channel
      end
      return channels
    end
end


