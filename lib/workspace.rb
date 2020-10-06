class Workspace
  attr_reader :users, :channels
  def initialize
    super
    @users = [],
    @channels = []
  end
end