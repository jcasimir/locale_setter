module LocaleSetter
  module User
    def self.for(user)
      if user
        user.locale
      end
    end
  end
end