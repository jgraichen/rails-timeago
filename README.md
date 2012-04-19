# rails-timeago

**rails-timeago** provides a timeago_tag helper to create time tags usable for
[jQuery Timeago](https://github.com/rmm5t/jquery-timeago) plugin.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-timeago'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails-timeago

To use bundled jQuery Timeago plugin add this require statement to your application.js file:

    //= require rails-timeago

This will also convert all matching time tags on page load.

## Usage

Use the timeago_tag helper like any other regular tag helper:

```erb
<%= timeago_tag Time.zone.now, :nojs => true, :limit => 10.days.ago %>
```


### Available options:

**nojs**
Add time ago in words as time tag content instead of absolute time.
(default: false)

**date_only**
Only print date as tag content instead of full time.
(default: true)

**format**
A time format for localize method used to format static time.
(default: default)

**limit**
Set a limit for time ago tags. All dates before given limit will not be converted.
(default: 4.days.ago)

**force**
Force time ago tag ignoring limit option.
(default: false)

**default**
String that will be returned if time is nil.
(default: '-')


All other options will be given as options to the time tag helper.
The above options can be assigned globally as defaults using

```ruby
Rails::Timeago.default_options :limit => proc { 20.days.ago }, :nojs => true
```

A global limit should always be given as a block that will be evaluated each time
the rails timeago_tag helper is called. That avoids the limit becoming smaller the
longer the application runs.

## I18n

**Note:** Available since version *1.2.0.rc1*. I18n features are still untested.

**rails-timeago** provides additional localization features and includes locale
files for the following locales taken from [jQuery Timeago](https://github.com/rmm5t/jquery-timeago).

> ar, bg, bs, ca, cy, cz, da, de, el, en, es, fa, fi, fr,
> he, hr, hu, hy, id, it, ja, ko, nl, no, pl, pt, ro, ru,
> sv, tr, uk, zh-CN, zh-TW

**rails-timeago** will automatically include the locale file for your current
locale if it is available. You only have to include the following method into
your html head tag:

```ruby
<%= timeago_script_tag %>
```

That will add a script include tag to include the needed locale file.
**rails-timeago** will also add all locale files to Rails precompiled assets
list to allow precompilation. By default all locale files will be included but
you can specify a list by adding a initializer similar to:

```ruby
Rails::Timeago.locales = [:en, :de]
```

This will only add English and German locale files to precompiled assets.
To add your own locales add a file in JavaScript assets directory named
`locales/jquery.timeago.<locale>.js` and add your locale to `Rails::Timeago.locales`.

## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)

Copyright (c) 2012, Jan Graichen
