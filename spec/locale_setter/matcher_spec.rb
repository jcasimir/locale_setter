require 'spec_helper'

describe "LocaleSetter::Matcher" do
  it "can properly match mixed case locales" do
    LocaleSetter::Matcher.match(['EN-US'],['en-us']).should == :'en-us'
  end

  it "can properly match when the available locales are not all lower case" do
    LocaleSetter::Matcher.match(['es-CL'],['es-CL']).should == :'es-CL'
  end

  it "can match using a single string" do
    LocaleSetter::Matcher.match('en', ['en']).should == :en
  end

  it "can match using an array" do
    LocaleSetter::Matcher.match(['en','es'],['en','es']).should == :en
  end

  it "can fuzzy-match between locales with country and those without"
end