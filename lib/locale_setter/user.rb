# this is primarily for 1.8.7 support
# see http://www.ruby-doc.org/core-2.0/Symbol.html#method-i-empty-3F
unless :locale.respond_to? :empty?
  class Symbol
    def empty?
      self.to_s.empty?
    end
  end
end

module LocaleSetter
  module User
    def self.for(user, available)
      if user && user.respond_to?(locale_method) &&
         user.send(locale_method) && !user.send(locale_method).empty?
        LocaleSetter::Matcher.match user.send(locale_method), available
      end
    end

    def self.locale_method
      LocaleSetter.config.user_locale_method
    end

    def self.locale_method=(method_name)
      warn "Deprecation warning. You should use new block syntax for configuration."
      LocaleSetter.config.user_locale_method = method_name
    end
  end
end
