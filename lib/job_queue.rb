class JobQueue
  attr_accessor :jobs

  def initialize(jobs_structure)
    @jobs = load_jobs(jobs_structure)
  end

  def order
    validate!
    return @jobs.inject([]) do |ordered_jobs, job|
      if job_position = ordered_jobs.index(job.id)
        ordered_jobs.insert job_position, job.dependency
      else
        job.dependency.empty? ? ordered_jobs << job.id : ordered_jobs.concat([job.dependency, job.id])
      end
    end.uniq.join
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

    def sort_jobs(sorted, jobs)
      return sorted if jobs.empty?
      jobs.each do |job, dependency|
        unless jobs.key?(dependency)
          sorted << job
          jobs.delete(job)
        end
      end
      sort_jobs(sorted, jobs)
    end

    def validate!
      @jobs.each do |job|
        job.validate!
        raise CircularDependencyError if circular_dependency?(job.id, job.dependency)
      end
      return true
    end
end
