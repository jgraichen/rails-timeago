# rails-timeago

*rails-timeago* provides a timeago_tag helper to create time tags usable for 
[jQuery Timeago](https://github.com/rmm5t/jquery-timeago) plugin.

## Installation

Add this line to your application's Gemfile:

    gem 'rails-timeago'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails-timeago

To use bundled jQuery Timeago plugin add this require statement to your application.js file:

    //=require rails-timeago

## Usage

Use the timeago_tag helper like any other regular tag helper:

    <%= timeago_tag Time.zone.now, :nojs => true, :limit => 10.days.ago %>


### Available options:

* nojs
  Add time ago in words as time tag content instead of absolute time. (default: false)

* date_only
  Only print date as tag content instead of full time. (default: true)

* format
  A time format for localize method used to format static time. (default: default)
 
* limit
  Set a limit for time ago tags. All dates before given limit will not be converted. (default: 4.days.ago) 

* force
  Force time ago tag ignoring limit option. (default: false)

All other options will be given as options to the time tag helper.

## License

[MIT License](http://www.opensource.org/licenses/mit-license.php)

Copyright (c) 2012, Jan Graichen
