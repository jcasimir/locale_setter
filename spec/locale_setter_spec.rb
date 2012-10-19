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

  describe "#default_url_options" do
    let(:controller){ Controller.new }

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
end