module LocaleSetter
  module Domain

    def self.for(domain, available)
      LocaleSetter::Matcher.match get_domain(domain), available
    end

    def self.get_domain(domain)
      LocaleSetter.config.localized_domains[domain]
    end

    def self.localized_domains=(domains)
      warn "Deprecation warning. You should use a new block syntax for configuration."
      LocaleSetter.config.localized_domains = domains
    end
  end
end