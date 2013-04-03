require 'spec_helper'

describe LocaleSetter do
  context "configuring" do

    before { described_class.configuration = nil }

    it "should be possible to set values via plain calls" do
      described_class.config.url_param = :some_method
      expect(described_class.config.url_param).to eq(:some_method)
    end

    it "should be possible to set values via block" do
      described_class.configure do |conf|
        conf.url_param = :some_method
      end

      expect(described_class.config.url_param).to eq(:some_method)
    end

    it "initializes config with default values" do
      expect(described_class.config.url_param).to eq(described_class::URL_PARAM)
      expect(described_class.config.user_locale_method).to eq(described_class::USER_METHOD)
      expect(described_class.config.localized_domains).to eq({})
      expect(described_class.config.current_user_method).to eq(described_class::CURRENT_USER_METHOD)
    end
  end
end