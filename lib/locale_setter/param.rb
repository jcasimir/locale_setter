module LocaleSetter
  module Param
    def self.for(param)
      LocaleSetter::Matcher.match([param])
    end
  end
end