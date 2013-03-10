require 'request_helper'
require 'support/dummy_app'
require 'support/matchers/have_text'

app = DummyApp.new(ENV["RAILS_ENV"])

app.start_server do
  describe "articles#index" do
    it "uses the default locale title by default" do
      page = app.get("/articles")
      expect(page).to have_text("Hello, World!")
    end

    context "with a URL parameter locale" do
      it "uses the specified locale title" do
        page = app.get("/articles?locale=arr")
        expect(page).to have_text("A'hoy, mate!")
      end
    end

    context "with a current_user who specifies a locale" do
      it "uses the specified locale title" do
        page = app.get("/articles?user=true")
        expect(page).to have_text("Hello, User!")
      end
    end

    context "with only HTTP_ACCEPT_LANGUAGE specified" do
      Capybara.register_driver :rack_test_accept_language do |app|
        Capybara::RackTest::Driver.new(app, :headers => { 'HTTP_ACCEPT_LANGUAGE' => 'http' })
      end

      it "uses the specified locale title" do
        pending "needs refactoring to work with new setup" do
          Capybara.current_driver = :rack_test_accept_language
          page = app.get("/articles")
          expect(page).to have_text("Hello, HTTP!")
          Capybara.use_default_driver
        end
      end
    end
  end
end
