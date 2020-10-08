
require_relative 'test_helper'
require_relative '../lib/recipient'


describe Recipient do
  before do
    @recipient = Recipient.new('T016J51T03T', 'test')
  end

  describe 'initializer' do
    it "creates instance a the Recipient" do
      expect(@recipient).must_be_kind_of Recipient
    end

    it "check the attributes" do
      expect(@recipient.slack_id).must_be_kind_of String
      expect(@recipient.name).must_be_kind_of String
    end
  end

  # send message test
  # self get test
  # details test

  describe 'list_all' do
    it "raise error if it's not implemented in a child class" do
      expect {Recipient.list_all}.must_raise NotImplementedError
    end
  end



end