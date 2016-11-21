require 'spec_helper'

describe MercuryParser do

  after do
    MercuryParser.reset!
  end

  describe "#new" do
    it "is a MercuryParser::Client" do
      expect(MercuryParser.new).to be_a_kind_of(MercuryParser::Client)
    end
  end
end
