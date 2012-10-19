require 'spec_helper'

describe 'LocaleSetter::User' do
  describe '#for' do
    it "ignores a blank stored locale" do
      blank = OpenStruct.new({:locale => ""})
      LocaleSetter::User.for(blank).should_not be
    end

    it "ignores a stored locale that is not available" do
      invalid = OpenStruct.new({:locale => "woof"})
      LocaleSetter::User.for(invalid).should_not be
    end

    it "only tries current_user if it offers a locale" do
      no_locale = OpenStruct.new()
      LocaleSetter::User.for(no_locale).should_not be
    end
  end
end