require 'spec_helper'

describe LocaleSetter do
  it "exists" do
    expect{ LocaleSetter }.to_not raise_error
  end

  class BareController; end

  describe ".included" do

    it "sets a before filter" do
      BareController.should_receive(:before_filter).with(:set_locale)
      BareController.send(:include, LocaleSetter)
    end

    it "skips setting the before_filter if not supported" do
      expect{ BareController.send(:include, LocaleSetter) }.to_not raise_error
    end
  end

  class Controller
    include LocaleSetter
  end

  let(:controller){ Controller.new }

  describe "#i18n" do
    it "uses the pre-set i18n library" do
      stand_in = OpenStruct
      controller.i18n = stand_in
      controller.i18n.should == stand_in
    end

    class I18n; end

    it "uses the default I18n library when not overridden" do
      controller.i18n.should == I18n
    end
  end

  describe "#default_url_options" do
    it "adds a :locale key" do
      controller.default_url_options({})[:locale].should be
    end

    it "builds on passed in options" do
      result = controller.default_url_options({:test => true})
      result[:test].should be
      result[:locale].should be
    end

    it "defers to a passed in locale" do
      result = controller.default_url_options({:locale => 'abc'})
      result[:locale].should == 'abc'
    end
  end

  describe "#set_locale" do
    context "with HTTP headers" do
      let(:controller){ HTTPController.new }

      class HTTPController < Controller
        def request
          OpenStruct.new(:env => {'HTTP_ACCEPT_LANGUAGE' => "es;en"})
        end
      end

      it "makes use of the HTTP headers" do
        controller.set_locale
        controller.i18n.locale.should == :es
      end

      it "only sets an available locale" do
        I18n.available_locales = [:arr, :en]
        controller.set_locale
        controller.i18n.locale.should == :en
      end
    end

    context "with a current_user who has a locale" do
      let(:controller){ UserController.new }  

      before(:each) do
        controller.i18n.available_locales = [:en, :user_specified]
      end

      class UserController < HTTPController
        def current_user
          OpenStruct.new({:locale => :user_specified})
        end
      end

      it "prioritizes the current_user preference over HTTP" do
        LocaleSetter::HTTP.should_not_receive(:for)
        controller.set_locale
      end

      it "uses the stored locale" do
        controller.set_locale
        controller.i18n.locale.should == :user_specified
      end
    end
  end
end