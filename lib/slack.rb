#!/usr/bin/env ruby
require_relative 'workspace'
require 'dotenv'
require 'httparty'
require 'table_print'
require 'table_print'
require_relative 'recipient'
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  #========do not remove below lines **sure, but the feedback states this should be hidden in another file.
  # looping and get the name of each channel
  # pp response
  # response['channels'].each do |channel|
  #   p channel['name']
  # end
  #=======================
  # pp user_response
  # user_response["members"].each do |member|
  #   p member["name"]
  # end
  #=============
  # response = HTTParty.get('https://slack.com/api/conversations.list', query: {token: ENV['SLACK_TOKEN']})
  # user_response = HTTParty.get('https://slack.com/api/users.list', query: {token: ENV['SLACK_TOKEN']})

  user_input = request_input

  until user_input == "quit"
    case user_input
      when "list_user"
        tb workspace.users, :name, :slack_id, :real_name
      when "list_channel"
        tb workspace.channels, :name, :topic, :member_count, :slack_id
      when "quit"
        break
      else
        user_input = request_input
      end
  end
  puts "Thank you for using the Ada Slack CLI"
end

def request_input
  puts "please select one from the list: "
  puts "what would you like to do: "
  puts "list_user"
  puts "list_channel"
  puts "quit"
  return  gets.chomp.downcase
end

main if __FILE__ == $PROGRAM_NAME