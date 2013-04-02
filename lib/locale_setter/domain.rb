module LocaleSetter
  module Domain
    @@localized_domains = {}

    def self.for(domain, available)
      LocaleSetter::Matcher.match get_domain(domain), available
    end

    def self.get_domain(domain)
      @@localized_domains[domain]
    end

    def self.localized_domains=(domains)
      @@localized_domains = domains
    end
  end
end