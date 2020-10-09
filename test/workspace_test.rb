require_relative 'test_helper'
require_relative '../lib/workspace'

describe "workspace" do

  before do
    VCR.use_cassette("workspace") do
      @workspace = Workspace.new
      # Any tests involving a User should use the username SlackBot
      @test_user = @workspace.select_user("slackbot")
      # Any tests involving a Channel should use the #random channel
      @test_channel = @workspace.select_channel("random")
    end
  end

  describe "initializer" do
    it "check the workspace instances" do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users).must_be_kind_of Array
    end
  end

  describe "select_channel" do
    it "select specific channel" do
      expect(@workspace).must_respond_to :select_channel
    end
    it "returns the selected channel" do
      expect(@workspace.select_channel("general")).must_be_kind_of Channel
      expect(@workspace.selected.slack_id).must_equal 'C0165N9BX3M'
      expect(@workspace.select_channel("wrongchannel")).must_be_nil
    end

    it "let user know when the selected channel is nil" do
      expect(@workspace.select_channel("wrongchannel")).must_be_nil
    end
  end

  describe "select_user" do
    it "select specific user" do
      expect(@workspace).must_respond_to :select_user
    end
    it "returns the selected user" do
      expect(@workspace.select_user("slackbot")).must_be_kind_of User
      selected_user = @workspace.select_user('pbui17')
      expect(@workspace.selected.slack_id).must_equal 'U016VKEDCFR'
    end

    it "if selected user doesnt exit, return nil" do
      expect(@workspace.select_user("hgrdsd")).must_be_nil
    end
  end

  describe "show_details" do
    it "print out details" do
      expect(@workspace).must_respond_to :show_details
    end

    it "print out details for the currently selected recipient " do
      @workspace.select_user('slackbot')
      expect(@workspace.show_details).must_be_kind_of String
      @workspace.select_channel('general')
      expect(@workspace.show_details).must_be_kind_of String
    end

    it "invalid info returns nil" do
      @workspace.select_user('hgddr')
      expect(@workspace.show_details).must_be_nil
      @workspace.select_channel('notchtgh')
      expect(@workspace.show_details).must_be_nil
    end
  end

  describe "send_message" do
    it "respond to the call" do
      expect(@workspace).must_respond_to :send_message
    end

    it "returns nil for selecting invalid info" do
      @workspace.select_user('invalid')
      expect(@workspace.send_message('test')).must_be_nil
      @workspace.select_channel('notchtkk')
      expect(@workspace.send_message('testtest')).must_be_nil
    end

    it "shows selected recipient info" do
      VCR.use_cassette("this is a test") do
        @workspace.select_user('slackbot')
        expect(@workspace.send_message('test message')).must_equal true
        @workspace.select_channel('test-channel2')
        expect(@workspace.send_message('test message')).must_equal true
      end
    end
  end
end