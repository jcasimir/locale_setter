require 'spec_helper'

describe LocaleSetter::Domain do
  describe '#for' do
    before { described_class.localized_domains = { "my_domain.com" => "domain_locale" }}

    it "ignores a blank domain" do
      expect(described_class.for("", ["domain_locale"])).not_to be
    end

    it "ignores domains not from the list" do
      expect(described_class.for("my_domain.com", ["default"])).not_to be
    end

    it "detects right domain" do
      expect(described_class.for("my_domain.com", ["domain_locale"])).to eq(:domain_locale)
    end
  end
end