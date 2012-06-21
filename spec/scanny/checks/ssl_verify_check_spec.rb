require "spec_helper"

module Scanny::Checks
  describe SSLVerifyCheck do
    before :each do
      @runner = Scanny::Runner.new(SSLVerifyCheck.new)
      @message =  "Disable certificate verification can" +
                  "lead to connect to an unauthorized server"
      @issue = issue(:high, @message, [296, 297, 298, 299, 300, 599])
    end

    it "reports usage of \"OpenSSL::SSL::VERIFY_NONE\" correctly" do
      @runner.should  check("OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE").
                      with_issue(@issue)
    end

    it "reports \"ca_file = nil\" correctly" do
      @runner.should check("ca_file = nil").with_issue(@issue)
    end

    it "reports \"@ca_file = nil\" correctly" do
      @runner.should check("@ca_file = nil").with_issue(@issue)
    end

    it "reports \"ca_path = nil\" correctly" do
      @runner.should check("ca_path = nil").with_issue(@issue)
    end

    it "reports \"@ca_path = nil\" correctly" do
      @runner.should check("@ca_path = nil").with_issue(@issue)
    end
  end
end
