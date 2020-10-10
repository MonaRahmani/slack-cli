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


  def select_user(id)
    user = @users.find do |user|
      user.slack_id == id || user.name == id
    end
    @selected = user
    puts "#{id} not exist" if @selected.nil?
    return @selected
  end


  def show_details
    if @selected.nil?
      puts "Nothing selected, pick a user or channel first."
    else
      return @selected.details
    end
  end

  def send_message(message)
    if @selected.nil?
      puts "No recipient selected"
    else
      begin
        return @selected.send_message(message)
      rescue SlackAPIError => exception
        puts "error: #{exception}"
      end

    end
  end
end





