//
// jQuery Timeago bootstrap for rails-timeago helper
//
//= require jquery.timeago

jQuery(document).ready(function() {
  $('time[data-time-ago]').timeago();
});