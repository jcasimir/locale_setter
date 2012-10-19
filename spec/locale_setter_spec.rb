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

  describe "#default_url_options" do
    it "adds a :locale key" do
      controller.default_url_options({})[:locale].should be
    end

    it "does not require a parameter" do
      expect{ controller.default_url_options }.to_not raise_error
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

    it "doesn't appent a locale if it's the default" do
      controller.i18n.locale = controller.i18n.default_locale
      controller.default_url_options({})[:locale].should_not be
    end

    it "appends a locale when not the default" do
      controller.i18n.locale = :sample
      controller.default_url_options({})[:locale].should == :sample
    end
  end

  describe "#set_locale" do
    context "with nothing" do
      let(:controller){ Controller.new }

      it "uses the default" do
        controller.set_locale
        controller.i18n.locale.should == controller.i18n.default_locale
      end
    end

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

    context "with url parameters" do
      let(:controller){ ParamController.new }

      before(:each) do
        controller.i18n.available_locales = [:en, :param_specified]
      end

      class ParamController < Controller
        def params
          {:locale => "param_specified"}
        end
      end

      it "uses the URL parameter" do
        controller.set_locale
        controller.i18n.locale.should == :param_specified
      end

      it "only allows supported locales" do
        controller.i18n.available_locales = [:en]
        controller.set_locale
        controller.i18n.locale.should == controller.i18n.default_locale
      end

      it "does not pollute the symbol table when given an unsuported locale" do
        class BadParamController < Controller
          def params
            {:locale => "bad_param"}
          end
        end
        expect { BadParamController.new.set_locale }.to_not change{ Symbol.all_symbols.count }
      end
    end
  end

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
end