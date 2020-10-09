#!/usr/bin/env ruby
require_relative 'workspace'
require 'dotenv'
require 'table_print'
require 'terminal-table'

def main
  Dotenv.load
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new

  user_input = request_input
  until user_input == "quit"

    case user_input
    when "list users", '1'
      tp workspace.users, :name, :slack_id, :real_name
    when "list channels", '2'
      tp workspace.channels, :name, :topic, :member_count, :slack_id
    when "select user", '3'
      puts "What is the slack Id"
      id = gets.chomp
      unless workspace.select_user(id).empty?
        puts "enter details to see information about #{id}"
        puts "enter send message to send a message to #{id}"
      end
    when "select channel", '4'
      puts "Please type the channel name: "
      id = gets.chomp
      if workspace.select_channel(id).nil?
        puts "#{id} is not a channel, try again?"
      else
        puts "enter details to see information about #{id}"
        puts "enter 'send message' to send a message to #{id}"
      end
    when "details", '5'
      puts workspace.show_details
    when "send message", '6'
      puts "Please type your message: "
      message = gets.chomp
      unless workspace.send_message(message).empty?
        puts "Your message was sent!"
      end
    when "quit", '7'
      break
    end
    puts "======================================="
    puts "Would you like to select another option?"
    user_input = request_input
  end
  puts "Thank you for using the Ada Slack CLI"
end
def request_input
  options_table = [[1, 'List Users'], [2, 'List Channels'], [3, 'Select User'],
                   [4, 'Select Channel'], [5, 'Details'], [6, 'Send Message'], [7, 'QUIT']]

  options = Terminal::Table.new :title => 'What would you like to do?', :rows => options_table
  puts options

  return  gets.chomp.downcase
end
main if __FILE__ == $PROGRAM_NAME
