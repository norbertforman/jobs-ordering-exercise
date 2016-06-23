require 'helper_spec'

describe JobQueue do
  describe "valid job structure: empty" do
    it "empty job structure" do
      job_structure = ""
      jobQueue = JobQueue.new(job_structure)
      expect(jobQueue.order).to eq ""
    end
  end

  describe "valid job structure: a =>" do
    it "job structure: a =>" do
      job_structure = "a =>"
      jobQueue = JobQueue.new(job_structure)
      expect(jobQueue.order).to eq "a"
    end
  end

  describe "valid job structure: a => b => c c =>" do
    before :all do
      job_structure = "a =>\nb => c\nc =>"
      jobQueue = JobQueue.new(job_structure)
      @ordered = jobQueue.order
    end

    it "a before c" do
      expect(@ordered).to match 'a.*c'
    end

    it "c before b" do
      expect(@ordered).to match 'c.*b'
    end
  end

  describe "valid job structure: a => b => c c => f d => a e => b f =>" do
    before :all do
      job_structure = "a =>\nb => c\nc => f\nd => a\ne => b\nf =>"
      jobQueue = JobQueue.new(job_structure)
      @ordered = jobQueue.order
    end

    it "c before b" do
      expect(@ordered).to match 'c.*b'
    end

    it "f before c" do
      expect(@ordered).to match 'f.*c'
    end

    it "a before d" do
      expect(@ordered).to match 'a.*d'
    end

    it "b before e" do
      expect(@ordered).to match 'b.*e'
    end
  end

  describe "invalid job structure SelfDependencyError" do
    it "job structure: a => b => c => c" do
      job_structure = "a => \nb => \nc => c"
      jobQueue = JobQueue.new(job_structure)
      expect{ jobQueue.order }.to raise_error(SelfDependencyError)
    end
  end

  describe "invalid job structure CircularDependencyError" do
    it "job structure: a => b => c c => f d => a e => f => b" do
      job_structure = "a => \nb => c\nc => f\nd => a\ne => \nf => b"
      jobQueue = JobQueue.new(job_structure)
      expect{ jobQueue.order }.to raise_error(CircularDependencyError)
    end
  end
end
