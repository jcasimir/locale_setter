require 'spec_helper'

describe LocaleSetter::Rails do
  it "exists" do
    expect{ LocaleSetter::Rails }.to_not raise_error
  end

  class BareController; end

  describe ".included" do
    it "sets a before filter" do
      BareController.should_receive(:before_filter).with(:set_locale)
      BareController.send(:include, LocaleSetter::Rails)
    end

    it "skips setting the before_filter if not supported" do
      expect{ BareController.send(:include, LocaleSetter::Rails) }.to_not raise_error
    end
  end

  class Controller
    include LocaleSetter::Rails
  end

  let(:controller){ Controller.new }

  before(:each) do
    controller.i18n.locale = :es
  end

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
end