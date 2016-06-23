class Job
  attr_accessor :job_id, :dependency

  def initialize(job_id, dependency)
    @job_id = job_id
    @dependency = dependency
  end

  def validate!
    raise InvalidJobIdError if @job_id.empty?
    raise SelfDependencyError if @job_id == @dependency
    return true
  end
end
