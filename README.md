# rails-timeago

[![Gem Version](https://img.shields.io/gem/v/rails-timeago?logo=ruby)](https://rubygems.org/gems/rails-timeago)
[![Build Status](https://img.shields.io/travis/jgraichen/rails-timeago/master?logo=travis)](https://travis-ci.org/jgraichen/rails-timeago)

**rails-timeago** provides a timeago_tag helper to create time tags usable for
[jQuery Timeago](https://github.com/rmm5t/jquery-timeago) plugin.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'rails-timeago', '~> 2.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails-timeago

To use bundled jQuery Timeago plugin add this require statement to your `application.js` file:

    //= require rails-timeago

This will also convert all matching time tags on page load.

Use the following to also include all available locale files:

    //= require rails-timeago-all

If using a recent Rails with `rails-ujs`, jQuery might not be present anymore. You need to add `jquery-rails` to your `Gemfile` and load it, e.g.:

    //= require jquery
    //= require rails-timeago
    //= require rails-timeago-all

## Usage

Use the timeago_tag helper like any other regular tag helper:

```erb
<%= timeago_tag Time.zone.now limit: 10.days.ago %>
```


### Available options:

**date_only**
Only print date as tag content instead of full time.
(default: `true`)

**format**
A time format for localize method used to format static time.
(default: `default`)

**limit**
Set a limit for time ago tags. All dates before given limit will not be converted.
(default: `4.days.ago`)

**force**
Force time ago tag ignoring limit option.
(default: `false`)

**default**
String that will be returned if time is `nil`.
(default: `'-'`)

**title**
A string or block that will be used to create a title attribute for timeago tags. It set to nil or false no title attribute will be set.
(default: `proc { |time, options| I18n.l time, format: options[:format] }`)

All other options will be given as options to the time tag helper.
The above options can be assigned globally as defaults using

```ruby
Rails::Timeago.default_options limit: proc { 20.days.ago }
```

A global limit should always be given as a block that will be evaluated each time the rails `timeago_tag` helper is called. That avoids the limit becoming smaller the longer the application runs.

## I18n

**rails-timeago 2** ships with a modified version of jQuery timeago that allows to include all locale files at once and set the locale via an option or per element via the `lang` attribute:

```erb
<%= timeago_tag Time.zone.now, lang: :de %>
```

The following snippet will print a script tag that set the jQuery timeago locale according to your `I18n.locale`:

```erb
<%= timeago_script_tag %>
```

Just insert it in your application layout's html head. If you use another I18n framework for JavaScript you can also directly set `jQuery.timeago.settings.lang`. For example:

```js
jQuery.timeago.settings.lang = $('html').attr('lang')
````

Do not forget to require the needed locale files by either require `rails-timeago-all` in your `application.js` file or require specific locale files:

```js
//= require locales/jquery.timeago.de.js
//= require locales/jquery.timeago.ru.js
```

*Note:* English is included in jQuery timeago library, but can be easily override by include an own file that defines `jQuery.timeago.settings.strings["en"]`. See a locale file for more details.

**rails-timeago** includes locale files for the following locales taken from [jQuery Timeago](https://github.com/rmm5t/jquery-timeago).

Your customized jQuery locale files must be changed to work with **rails-timeago 2**. Instead of defining your locale strings as `jQuery.timeago.settings.strings` you need to define them like this:

```js
jQuery.timeago.settings.strings["en"] = {
    ...
}
```

## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)

Copyright (c) 2014, Jan Graichen
