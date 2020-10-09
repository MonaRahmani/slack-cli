require_relative 'test_helper'
require_relative '../lib/recipient'


describe Recipient do
  before do
    @recipient = Recipient.new(slack_id: 'T016J51T03T', name: 'test')
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

  describe 'list_all' do
    it "raise error if it's not implemented in a child class" do
      expect do Recipient.list_all
      end.must_raise NotImplementedError
    end
  end

  describe 'details' do
    it "raise error if it's not implemented in a child class" do
      expect do @recipient.details
      end.must_raise NotImplementedError
    end
  end

  describe 'send_message' do
    before do
      @correct_recipient = Recipient.new(slack_id: 'U017GNU2E20', name: 'Mona')
    end
    it "send_message" do
      expect(@recipient).must_respond_to :send_message
    end

    it "raise error if API call fails" do
      VCR.use_cassette('message fail') do
        expect {
          @recipient.send_message('sending test')
        }.must_raise SlackAPIError
      end
    end

    it "works and message sends if recipient is correct" do
      VCR.use_cassette('test message sent') do
        expect(@correct_recipient.send_message("checking to see if our test send")).must_equal true
      end

    end
  end

end