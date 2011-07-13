require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Scanny::Checks::ShellExpansionCheck do
  before :each do
    @scanny = Scanny::Runner.new(Scanny::Checks::ShellExpansionCheck.new)
  end

  it "does not report regular method calls" do
    @scanny.should parse('foo').without_issues
  end

  describe "reported methods" do
    it "reports \"exec\" calls" do
      @scanny.should parse('exec "ls -l"').with_issue(:high,
        "The \"exec\" method can pass the executed command through shell exapnsion.")
    end

    it "reports \"system\" calls" do
      @scanny.should parse('system "ls -l"').with_issue(:high,
        "The \"system\" method can pass the executed command through shell exapnsion.")
    end
  end

  describe "argument counts" do
    it "does not report calls with no arguments" do
      @scanny.should parse('exec').without_issues
    end

    it "reports calls with one argument" do
      @scanny.should parse('exec "ls -l"').with_issue(:high,
        "The \"exec\" method can pass the executed command through shell exapnsion.")
    end

    it "does not report calls with multiple arguments" do
      @scanny.should parse('exec "ls", "-l"').without_issues
    end
  end
end
