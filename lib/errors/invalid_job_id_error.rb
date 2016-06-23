class InvalidJobIdError < StandardError
  attr_reader :message

  def initialize(message = "Job id can't be blank")
    super
    @message = message
  end
end
