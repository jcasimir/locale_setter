require 'spec_helper'

describe LocaleSetter::Domain do
  describe '#for' do
    before { described_class.localized_domains = { "my_domain.com" => "domain_locale" }}

    it "ignores a blank domain" do
      described_class.for("", ["domain_locale"]).should_not be
    end

    it "ignores domains not from the list" do
      described_class.for("my_domain.com", ["default"]).should_not be
    end

    it "detects right domain" do
      described_class.for("my_domain.com", ["domain_locale"]).should == :domain_locale
    end
  end
end