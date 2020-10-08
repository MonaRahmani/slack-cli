require_relative 'test_helper'
require_relative '../lib/workspace'


describe "workspace" do
  before do
    VCR.use_cassette("channels_list")
  end
end