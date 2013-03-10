require 'spec_helper'

describe 'LocaleSetter::User' do
  describe '#for' do
    it "ignores a blank stored locale" do
      blank = OpenStruct.new({:locale => ""})
      LocaleSetter::User.for(blank, ["default"]).should_not be
    end

    it "ignores a stored locale that is not available" do
      invalid = OpenStruct.new({:locale => "woof"})
      LocaleSetter::User.for(invalid, ["default"]).should_not be
    end

    it "only tries current_user if it offers a locale" do
      class NoLocaleUser; end
      LocaleSetter::User.for(NoLocaleUser.new, ["default"]).should_not be
    end

    it "uses a configurable field name" do
      class MyLocaleUser
        def my_locale
          "arr"
        end
      end

      LocaleSetter::User.locale_method = :my_locale

      user = MyLocaleUser.new
      LocaleSetter::User.for(user, ["arr"]).should == :arr
    end
  end
end