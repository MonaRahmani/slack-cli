class Workspace

  # we should create a method that give users related info
  # we need to use this method in slack.rb
  attr_reader :users, :channels
  def initialize
    super
    @users = [],
    @channels = []
  end
end