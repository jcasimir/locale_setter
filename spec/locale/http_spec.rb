require 'spec_helper'

describe "LocaleSetter::HTTP" do
  describe ".for" do
    let(:available){ ['en', 'es'] }

    context "when the first choice is supported" do
      context "given 'en'" do
        it "returns :en" do
          LocaleSetter::HTTP.for("en", available).should == :en
        end
      end

      context "given two acceptable locales" do
        it "returns :en" do
          LocaleSetter::HTTP.for("en,es", available).should == :en
        end
      end
    end

    context "when the first choice is not supported" do
      context "given 'en,es'" do
        it "returns :es" do
          LocaleSetter::HTTP.for("de,es", available).should == :es
        end
      end
    end

    context "when using preference weightings" do
      it "returns :en" do
        LocaleSetter::HTTP.for("en;1,es;0.8", available).should == :en
      end

      it "handles misordered preferences" do
        LocaleSetter::HTTP.for("es;0.8,en;1", available).should == :en
      end
    end
  end
end