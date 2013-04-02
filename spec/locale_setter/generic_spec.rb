require 'spec_helper'

describe LocaleSetter::Generic do
  let(:setter){ LocaleSetter::Generic }
  let(:i18n){ I18n }

  describe "#set_locale" do
    context "with nothing" do
      it "uses the default" do
        setter.set_locale(i18n)
        expect(i18n.locale).to eq(i18n.default_locale)
      end
    end

    context "with HTTP headers" do
      let(:request){ {'HTTP_ACCEPT_LANGUAGE' => "es,en"} }

      it "makes use of the HTTP headers" do
        i18n.available_locales = [:en, :es]
        setter.set_locale(i18n, {:env => request})
        expect(i18n.locale).to eq(:es)
      end

      it "only sets an available locale" do
        i18n.available_locales = [:arr, :en]
        setter.set_locale(i18n, {:env => request})
        expect(i18n.locale).to eq(:en)
      end

      it "does nothing when HTTP_ACCEPT_LANGUAGE is missing" do
        setter.set_locale(i18n, {:env => {}})
        expect(i18n.locale).to eq(i18n.default_locale)
      end
    end

    context "with a current_user who has a locale" do
      it "uses the stored locale" do
        i18n.available_locales = [:en, :user_specified]
        user = OpenStruct.new( {:locale => :user_specified} )
        setter.set_locale(i18n, {:user => user} )
        expect(i18n.locale).to eq(:user_specified)
      end
    end

    context "with localized domains" do
      it "uses the locale from config" do
        i18n.available_locales = [:en, :domain_specified]
        LocaleSetter::Domain.localized_domains = { "localized_domain.com" => :domain_specified }
        setter.set_locale(i18n, {:domain => "localized_domain.com"} )
        expect(i18n.locale).to eq(:domain_specified)
      end
    end

    context "with url parameters" do
      before(:each) do
        i18n.available_locales = [:en, :param_specified]
      end

      let(:params){ {:locale => "param_specified"} }

      it "uses the URL parameter" do
        setter.set_locale(i18n, {:params => params} )
        expect(i18n.locale).to eq(:param_specified)
      end

      it "only allows supported locales" do
        i18n.available_locales = [:en]
        setter.set_locale(i18n, {:params => params} )
        expect(i18n.locale).to eq(i18n.default_locale)
      end

      it "does not pollute the symbol table when given an unsuported locale" do
        expect { setter.set_locale(i18n, { :params => {:locale => "bad_param"} }) }.
               to_not change{ Symbol.all_symbols.count }
      end
    end
  end
end