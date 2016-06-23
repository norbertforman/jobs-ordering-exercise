class SelfDependencyError < StandardError
  attr_reader :message

  def initialize(message = "Jobs can't depend on themeselves")
    super
    @message = message
  end
end
