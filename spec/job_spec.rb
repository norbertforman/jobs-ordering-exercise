require 'helper_spec'

describe Job do
  describe "valid job" do
    it "has correct job id and dependency" do
      job = Job.new('a','b')
      expect(job.validate!).to eq true
    end
  end

  describe "invalid job InvalidJobIdError" do
    it "missing job id" do
      job = Job.new('','')
      expect{ job.validate! }.to raise_error(InvalidJobIdError)
    end
  end

  describe "invalid job SelfDependencyError" do
    it "self dependent job" do
      job = Job.new('a','a')
      expect{ job.validate! }.to raise_error(SelfDependencyError)
    end
  end
end
