source 'https://rubygems.org'

# Specify your gem's dependencies in locale_setter.gemspec
gemspec

platforms :ruby do
  gem "sqlite3"
end

platforms :jruby do
  gem "minitest", ">= 3.0"
  gem "activerecord-jdbcsqlite3-adapter"
end

version = ENV["RAILS_VERSION"] || "3.2"

rails = case version
when "master"
  {github: "rails/rails"}
else
  "~> #{version}.0"
end

gem "rails", rails
