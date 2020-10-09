require_relative 'channel'
require_relative 'user'


class Workspace
  attr_reader :users, :channels
  attr_accessor :selected

  def initialize
    @users = User.list_all
    @channels = Channel.list_all
    @selected = nil
  end

  def select_channel(id)
    requested_channel = @channels.find do |channel|
      channel.slack_id == id || channel.name == id
    end
    @selected = requested_channel
    return @selected
  end

  # user, should be able to supply a username or Slack ID.
  # corresponding user should be the "selected" recipient.(same for channel)
  #  if no user/channel has that name or ID, the program should let user know
  def select_user(id)
    user = @users.find do |user|
      user.slack_id == id || user.name == id
    end
    @selected = user
    puts "#{id} not exist" if @selected.nil?
    return @selected
  end

  # when user type "details the program should print out details for the currently selected recipient
  def show_details
    # will call the details method of the previously selected user or channel
    if @selected.nil?
      puts "nothing selected"
    else
      return @selected.details
    end
  end
end


def send_message(message)
  if @selected.nil?
    puts "no recipient selected"
  else
    puts "#{@selected.send_message(message)}"
    return @selected.send_message(message)
  end
end

