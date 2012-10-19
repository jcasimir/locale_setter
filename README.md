# LocaleSetter

`LocaleSetter` sets the locale for the current request in a Rails application.

## Rationale

One of the challenges with internationalization is knowing which locale a user actually wants. We recommend the following hierarchy of sources:

1. URL Parameter
2. User Preference
3. HTTP Headers
4. Default

### URL Parameter

As a developer or designer, it's incredibly handy to be able to manipulate the URL to change locales. You might even use this with CI to run your integration tests using each locale you support.

The parameter `locale` will be appended to every link.

## Installation

Add this line to your application's Gemfile:

    gem 'locale_setter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install locale_setter

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
