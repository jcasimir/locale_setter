# LocaleSetter

`LocaleSetter` sets the locale for the current request in a web application.
Rails has automatic support, other applications can use LocaleSetter with a
bit of configuration.

## Installation

Currently, LocaleSetter only supports Rails 3.2 and up. If you want 3.0 or
3\.1 support, please file an Issue and we can work it out.

### Gem Installation

Add this line to your application's Gemfile:

```ruby
gem 'locale_setter'
```

Then execute:

```
$ bundle
```

### Rails Application Configuration

There is none! Thanks, Railties!

### Non-Rails Applications

The library can be used outside of Rails by accessing `LocaleSetter::Generic` directly. You need to pass in your I18n class and the data sources, like this:

```
# Example Input Data
request = {'HTTP_ACCEPT_LANGUAGE' = 'en,es;0.6'}
params  = {:locale = 'en'}
user    = User.first
i18n    = I18n

# Set the .locale of I18n
LocaleSetter::Generic.set_locale(i18n,
                                {:env => request,
                                 :params => params,
                                 :user => user,
                                 :domain => domain})
```

The `i18n.locale=` will be called with the local selected from the passed data. `:env`, `:params`, `:domain` and `:user` are all optional.

## How It Works

One of the challenges with internationalization is knowing which locale a user actually wants. We recommend the following hierarchy of sources:

1. URL Parameter
2. User Preference
3. Domain Specific
4. HTTP Headers
5. Default

### Configuration

`LocaleSetter` can be configured via a block. Here are the defaults:

```ruby
LocaleSetter.configure do |config|
  config.url_param           = :locale
  config.user_locale_method  = :locale
  config.localized_domains   = {}
  config.current_user_method = :current_user
end
```

So if you want to change the defaults then call this method any time after
the library is loaded, like in a Rails initializer.

### URL Parameter

As a developer or designer, it's incredibly handy to be able to manipulate the URL to change locales. You might even use this with CI to run your integration tests using each locale you support.

If you're currently using the default locale for the application, generated URLs on your site will be untouched.

For example, say my default is `:en` for English and I am viewing in English, my URL might look like:

```
http://example.com/articles/1
```

If you're using a locale other than the default, then the parameter `locale` will be appended to every link.

For example, my default is still `:en` but I'm currently reading in Spanish (`:es`):

```
http://example.com/articles/1&locale=es
```

You do not need to do any handling of this URL parameter, `LocaleSetter` will take care of it.

If you *do* want to change the currently viewed locale, manipulate the URL parameter manually:

Starting with the default...

```
http://example.com/articles/1
```

I want to check out German, so I add `&locale=de`...

```
http://example.com/articles/1&locale=de
```

Then check things out in Spanish...

```
http://example.com/articles/1&locale=es
```

#### Non-Supported Locales

If the locale specified in the URL is not supported, `LocaleSetter` will revert to the default locale.

Note that care has been taken to prevent a symbol-table-overflow denial of service attack. Unsupported locales are not symbolized, so there is no danger.

### User Preference

If your system has authentication, then you likely use have a `current_user` helper method available. `LocaleSetter` will call `locale` on current user, expecting to get back a string response.

Both method names(`current_user` & `locale`) can be changed via a config block.

#### Storing a User Preference

The easiest solution is to add a column to your users table:

```
rails generate migration add_locale_to_users locale:string
rake db:migrate
```

Then, allow them to edit this preference wherever they edit other profile items (email, name, etc). You might use a selector like this:

```erb
<%= form_for @user do |f| %>
  <%= f.collection_select :locale, I18n.available_locales %>
<% end %>
```

Remember that you may need to modify the `user.rb` if you're filtering mass-assignment parameters.

### Locale-per-domain

You could specify prefered locale according to the domain (or subdomain).
Just specify domains hash via config block:

```ruby
LocaleSetter.configure do |config|
  config.localized_domains = {
    "en.domain.com" => :en,
    "es.domain.com" => :es
  }
end
```

### HTTP Headers

Every request coming into your web server includes a ton of header information. One key/value pair looks like this:

```
HTTP_ACCEPT_LANGUAGE='en-US,en;0.8,es;0.4'
```

This string is created and sent by the user's browser. Most users have never configured it, the browser just picks it up from the host OS. It can usually be controlled through some kind of advanced preference pane.

The sample string above means...

* I prefer US English (`en-US`) for full comprehension
* I will take general English (`en`) and will understand about 80% of the content
* I will take general Spanish (`es`) and will understand about 40% of the content

`LocaleSetter` will take care of processing this string and will use the highest-comprehension locale that your application supports.

### Default

Finally, if none of those previous options worked, the library will fall back to the currently specified `I18n.default_locale`.

## Contributing

This library is considered "experimental" quality. Your feedback would be very welcome! Pull requests are great, but issues are good too.

### Test Application / Example Usage

Check out https://github.com/jcasimir/locale_setter_test for a simple Rails application used to black-box test the library in real usage.

## License

Please see the included LICENSE.txt
