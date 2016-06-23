class CircularDependencyError < StandardError
  attr_reader :message

  def initialize(message = "Jobs can't have circular dependencies")
    super
    @message = message
  end
end
