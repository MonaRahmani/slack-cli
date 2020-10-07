#!/usr/bin/env ruby
require_relative 'workspace'
require 'dotenv'
require 'httparty'
require 'table_print'
require 'terminal-table'


def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  #========do not remove below lines **sure, but the feedback states this should be hidden in another file.
  response = HTTParty.get('https://slack.com/api/conversations.list', query: {token: ENV['SLACK_TOKEN']})
  user_response = HTTParty.get('https://slack.com/api/users.list', query: {token: ENV['SLACK_TOKEN']})
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

  # TODO project
  # wave1:
  # users should see information about how many channels and users were loaded
  # give user 3 options (list users, list channels, quit)
  #       ~~~~~~~~~~~
  # options_table = [[1, "List users"], [2, "List channels"], [3, "quit"]]
  #input = nil
  #       while input != "quit" || input != "3"
  # options = Terminal::Table.new :title => "What would you like to do?", :rows => options_table
  # puts options
  # input = gets.chomp.downcase
  #
  #          case options
  #           when "1", list users"
  #               tp Workspace.show_details "user" or Workspace.users
  #           when "2", "list channels"
  #               tp Workspace.show_details "channel" or Workspace.channels
  #
  #
  # start a while loop(arr.length do) and keep asking until user type quit
  # list users in this format => username(name), real name(real_name), slack ID(id)
  # list channels, this format => channels name(name), topic(topic), member count(members_count), slack ID(id)
  #       via workspace#show_details, using tp Workspace.show_details "channel", "users"
  #   ...or maybe shown using tp Workspace.channels, Workspace.users (since they are both arrays and therefore lists?)






  puts "Thank you for using the Ada Slack CLI"
end


main if __FILE__ == $PROGRAM_NAME