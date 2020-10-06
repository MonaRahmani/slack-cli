#!/usr/bin/env ruby
require_relative 'workspace'
require 'dotenv'
require 'httparty'
Dotenv.load

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts ENV['SLACK_TOKEN']

  # TODO project
  # wave1:
  # users should see information about how many channels and users were loaded

  response = HTTParty.get('https://slack.com/api/conversations.list', query: {token: ENV['SLACK_TOKEN']})
  user_response = HTTParty.get('https://slack.com/api/users.list', query: {token: ENV['SLACK_TOKEN']})

  #====================
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
  #========================


  puts "Thank you for using the Ada Slack CLI"
end


main if __FILE__ == $PROGRAM_NAME