# rails-timeago

[![Gem Version](https://badge.fury.io/rb/rails-timeago.svg)](http://badge.fury.io/rb/rails-timeago)
[![Build Status](https://travis-ci.org/jgraichen/rails-timeago.svg?branch=master)](https://travis-ci.org/jgraichen/rails-timeago)
[![Code Climate](https://codeclimate.com/github/jgraichen/rails-timeago.svg)](https://codeclimate.com/github/jgraichen/rails-timeago)
[![Dependency Status](https://gemnasium.com/jgraichen/rails-timeago.svg)](https://gemnasium.com/jgraichen/rails-timeago)

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
    
Within your `application.rb` file:

```ruby
class Application < Rails::Application
    Rails::Timeago.default_options :limit => proc { 20.days.ago }, :nojs => true  # adding this line
end
```

You can tweak the above options to your liking based on the items in the 'Available Options' section below.


## Usage

Use the timeago_tag helper like any other regular tag helper.  If you already have the settings the way you want them in application.rb, simply start using the timeago_tag helper in your view:

```erb
<%= timeago_tag Time.zone.now %>
```

Another example:  If you're creating a blog with a Post model, and want to show when your post was added. Something similar to:
```erb
<%= timeago_tag post.created_at %>
```

If you'd like to override your current global settings while using the helper in your view, you can directly insert your options:

```erb
<%= timeago_tag Time.zone.now, :nojs => true, :limit => 10.days.ago %>
```


### Available Options:

**nojs**
Add time ago in words as time tag content instead of absolute time.
(default: `false`)

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
(default: `proc { |time, options| I18n.l time, :format => options[:format] }`)

## I18n

**rails-timeago 2** ships with a modified version of jQuery timeago that allows to include all locale files at once and set the locale via an option or per element via the `lang` attribute:

```erb
<%= timeago_tag Time.zone.now, :lang => :de %>
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

> de cy pl mk zh-CN bs en-short it fi es uk lt zh-TW sk hy ca pt el sv ar no fa fr pt-br tr he bg ko uz cz sl hu id hr ru nl fr-short da ja ro th

Your customized jQuery locale files must be changed to work with **rails-timeago 2**. Instead of defining your locale strings as `jQuery.timeago.settings.strings` you need to define them like this:

```js
jQuery.timeago.settings.strings["en"] = {
    ...
}
```

## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)

Copyright (c) 2014, Jan Graichen
