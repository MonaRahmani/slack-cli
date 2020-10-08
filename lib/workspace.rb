require 'httparty'
require 'dotenv'
require 'table_print'

require_relative 'channel'
require_relative 'user'


Dotenv.load


class Workspace

    attr_reader :users, :channels
    attr_accessor :selected

    def initialize
      @users = user.list_all
      @channels = channel.list_all
      @selected = nil
    end

    def select_channel(id)
      channel = @channels.find do |channel|
        channel.slack_id = id || channel.name == id
      end
      @selected = channel

      if @selected.nil?
        return "no channel found"
      else
        return @selected.name
      end
    end

    # user, should be able to supply a username or Slack ID.
    # corresponding user should be the "selected" recipient.(same for channel)
    #  if no user/channel has that name or ID, the program should let user know
    def select_user(id)
      user = @users.find do |user|
        user.slack_id = id || user.name == id
      end
      @selected = user

      if @selected.nil?
        return "no user found"
      else
        return @selected.name
      end

    end


    def show_details
      # will call the details method of the previously selected user or channel
      @selected.details
    end

    def send_message

    end
end
