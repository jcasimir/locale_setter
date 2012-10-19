require 'spec_helper'

describe "LocaleSetter::Matcher" do
  it "can properly match mixed case locales" do
    LocaleSetter::Matcher.match(['EN-US'],['en-us']).should == :'en-us'
  end

  it "can fuzzy-match between locales with country and those without"
end