class JobQueue
  attr_accessor :jobs

  def initialize(jobs_structure)
    @jobs = load_jobs(jobs_structure)
  end

  def validate!
    @jobs.each do |job|
      job.validate!
      raise CircularDependencyError if circular_dependency?(job.id, job.dependency)
    end
    return true
  end

  private
    def load_jobs(jobs_structure)
      return jobs_structure.scan(/(.*) => ?(\w*)/)
        .map{ |job_id, dependency| Job.new(job_id, dependency) }
    end

    def circular_dependency?(parent, child)
      return true if parent == child
      return false if child.empty?
      child_dependency = @jobs.select { |job| job.id == child }.first
      raise InvalidJobIdError if child_dependency.nil?
      circular_dependency?(parent, child_dependency.dependency)
    end
end
