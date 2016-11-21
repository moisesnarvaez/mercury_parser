require 'spec_helper'

describe MercuryParser::Client do

  after do
    MercuryParser.reset!
  end

  context "with module configuration" do
    before do
      MercuryParser.configure do |config|
        MercuryParser::Configuration::VALID_CONFIG_KEYS.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    it "inherits the module configuration" do
      MercuryParser::Configuration::VALID_CONFIG_KEYS.each do |key|
        expect(MercuryParser.send(:"#{key}")).to eq(key)
      end
    end
  end

  context "with class configuration" do
    before do
      @configuration = {
        api_key: '1234'
      }
    end

    it "overrides the module configuration after initialization" do
      MercuryParser.configure do |config|
        @configuration.each do |key, value|
          config.send("#{key}=", value)
        end
      end

      MercuryParser::Configuration::VALID_OPTIONS_KEYS.each do |key|
        expect(MercuryParser.send(:"#{key}")).to eq(@configuration[key])
      end
    end
  end

  describe "#connection" do
    it "looks like Faraday connection" do
      expect(subject.send(:connection)).to respond_to(:run_request)
    end
  end

  describe "#request" do
    before { MercuryParser.api_key = '1234' }

    it "catches Faraday connection errors" do
      skip
    end

    it "catches Mercury Parser API errors" do
      skip
    end
  end
end
