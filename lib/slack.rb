#!/usr/bin/env ruby
require_relative 'workspace'
require 'dotenv'
require 'table_print'
def main
  Dotenv.load
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  user_input = request_input
  until user_input == "quit"
    case user_input
    when "list user"
      puts workspace.users, :name, :slack_id, :real_name
    when "list channel"
      puts workspace.channels, :name, :topic, :member_count, :slack_id
    when "select user"
      puts "What is the slack Id"
      id = gets.chomp
      unless workspace.select_user(id).empty?
        puts "enter details to see information about #{id}"
        puts "enter send message to send a message to #{id}"
      end
    when "select channel"
      puts "please type the channel name: "
      id = gets.chomp
      unless workspace.select_channel(id).empty?
        puts "enter details to see information about #{id}"
        puts "enter send message to send a message to #{id}"
      end
    when "details"
      puts workspace.show_details
    when "send message"
      puts "please type your message: "
      message = gets.chomp
      unless workspace.send_message(message).empty?
        puts "your messaged sent"
      end
    when "quit"
      break
    end
    puts "======================================="
    puts "would you like to select another option?"
    user_input = request_input
  end
  puts "Thank you for using the Ada Slack CLI"
end
def request_input
  puts "please select one from the list: "
  puts "what would you like to do: "
  puts "list user"
  puts "list channel"
  puts "select user"
  puts "select channel"
  puts "details"
  puts "send message"
  puts "quit"
  puts "======================================="
  return  gets.chomp.downcase
end
main if __FILE__ == $PROGRAM_NAME
