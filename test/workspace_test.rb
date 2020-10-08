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

  #select_channel
  describe "select_channel" do
    it "select specific channel" do
      expect(@workspace).must_respond_to :select_channel
    end

    it "returns the selected channel" do
      expect(@workspace.select_channel("random")).must_be_kind_of Channel
    end

    expect(@workspace.select_channel("random")).must_equal @workspace.selected.name
  end

  it "let user know when the selected channel is nil" do
    expect(@workspace.select_channel("notexist")).must_equal "no channel found"
  end

  # select_user
  describe "select_user" do
    it "select specific user" do
      expect(@workspace).must_respond_to :select_user
    end

    it "returns the selected user" do
      expect(@workspace.select_user("slackbot")).must_be_kind_of User
    end

    expect(@workspace.select_user("slackbot")).must_equal @workspace.selected.name
    expect(@workspace.selected.slack_id.must_equal).must_equal "USLACKBOT"
  end

  it "let user know when the selected user is nil" do
    expect(@workspace.select_user("notexist")).must_equal "no user found"
  end

  describe "show_details" do
    it "print out details" do
      expect(@workspace).must_respond_to :show_details
    end

    it "print out details for the currently selected recipient " do
      expect(@workspace.selected.show_details).must_be_kind_of Channel
      expect(@workspace.selected.show_details).must_be_kind_of User
    end
  end


end