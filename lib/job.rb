class Job
  attr_accessor :id, :dependency

  def initialize(id, dependency)
    @id = id
    @dependency = dependency
  end

  def validate!
    raise InvalidJobIdError if @id.empty?
    raise SelfDependencyError if @id == @dependency
    return true
  end
end
