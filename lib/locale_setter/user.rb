module LocaleSetter
  class User
    @@user_locale_method = :locale

    def self.for(user, available)
      if user && user.respond_to?(locale_method) && 
         user.send(locale_method) && !user.send(locale_method).empty?
        LocaleSetter::Matcher.match user.send(locale_method), available
      end
    end

    def self.locale_method
      @@user_locale_method
    end

    def self.locale_method=(method_name)
      @@user_locale_method = method_name
    end
  end
end