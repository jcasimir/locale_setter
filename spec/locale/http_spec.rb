require 'spec_helper'

describe "LocaleSetter::HTTP" do
  describe ".for" do
    context "when the first choice is supported" do
      before(:each){ I18n.available_locales = [:en, :es] }
      
      context "given 'en'" do
        it "returns :en" do
          LocaleSetter::HTTP.for("en").should == :en
        end
      end

      context "given two acceptable locales" do
        it "returns :en" do
          LocaleSetter::HTTP.for("en;es").should == :en
        end
      end
    end

    context "when the first choice is not supported" do
      before(:each){ I18n.available_locales = [:es] }
      
      context "given 'en;es'" do
        it "returns :es" do
          LocaleSetter::HTTP.for("en;es").should == :es
        end
      end
    end

    context "when using preference weightings" do
      before(:each){ I18n.available_locales = [:en, :es] }

      it "returns :en" do
        LocaleSetter::HTTP.for("en,1;es,0.8").should == :en
      end

      it "handles misordered preferences" do
        LocaleSetter::HTTP.for("es,0.8;en,1").should == :en
      end
    end
  end
end