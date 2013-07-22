//
// jQuery Timeago bootstrap for rails-timeago helper
//
//= require jquery.timeago

jQuery(document).on('ready page:load', function() {
  $('time[data-time-ago]').each(function() { 
    var $this = $(this); 
    if ($this.data('timeago-active') != 'true') { 
      $this.timeago().data('timeago-active', 'true');
    }
  });
});