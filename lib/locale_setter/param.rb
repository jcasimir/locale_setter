module LocaleSetter
  module Param
    def self.for(param)
      LocaleSetter::Matcher.match([param.to_sym])
    end
  end
end