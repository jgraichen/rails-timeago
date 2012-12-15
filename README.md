# rails-timeago

**rails-timeago** provides a timeago_tag helper to create time tags usable for
[jQuery Timeago](https://github.com/rmm5t/jquery-timeago) plugin.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-timeago', '~> 2.0.0.beta1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails-timeago

To use bundled jQuery Timeago plugin add this require statement to your application.js file:

    //= require rails-timeago

This will also convert all matching time tags on page load.

Use the following to also include all available locale files:

	//= require rails-timeago-all

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

A global limit should always be given as a block that will be evaluated each time the rails timeago_tag helper is called. That avoids the limit becoming smaller the longer the application runs.

## I18n

**rails-timeago 2** ships with a modified version of jQuery timeago that allows to include all locale files at once and set the locale via an option or per element via the `lang` attribute:

```erb
<%= timeago_tag Time.zone.now, :lang => :de %>
```

The following snippet will print a script tag that set the jQuery timeago locale according to your `I18n.locale`:

```ruby
<%= timeago_script_tag %>
```

Just insert it in your application layout's html head. If you use another I18n framework for JavaScript you can also directly set `jQuery.timeago.settings.lang`.

Do not forget to require the needed locale files by either require `rails-timeago-all` in your `application.js` file or require specific locale files:

	//= require locales/jquery.timeago.de.js
	//= require locales/jquery.timeago.ru.js

*Note:* English is included in jQuery timeago library, but can be easily override by include an own file that defines `jQuery.timeago.settings.strings["en"]`. See a locale file for more details.

**rails-timeago** includes locale files for the following locales taken from [jQuery Timeago](https://github.com/rmm5t/jquery-timeago).

> ar, bg, bs, ca, cy, cz, da, de, el, en, en-short, es, fa, fi, fr,
> he, hr, hu, hy, id, it, ja, ko, mk, nl, no, pl, pt, pt-br, ro, ru,
> sv, tr, uk, uz, zh-CN, zh-TW

Your customized jQuery locale files must be changed to work with **rails-timeago 2**. Instead of defining your locale strings as `jQuery.timeago.settings.strings` you need to define them like this:

	jQuery.timeago.settings.strings["en"] = {
		...
	}

## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)

Copyright (c) 2012, Jan Graichen
