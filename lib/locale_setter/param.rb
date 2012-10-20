module LocaleSetter
  module Param
    def self.for(param, available)
      LocaleSetter::Matcher.match([param], available)
    end
  end
end