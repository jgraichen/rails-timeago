//
// jQuery Timeago bootstrap for rails-timeago helper
//
//= require jquery.timeago

var activate_timeago_timeout;

jQuery(document).on('ready page:load', function() {
  activate_timeago();
});

// Activate Timeago
// Runs every minute and ensures that timeago is applied to each element only once.
// Based on rmm5t's example on https://github.com/rmm5t/jquery-timeago/wiki/Tips
function activate_timeago() { 
  // Make sure this is the only timeout waiting to trigger
  clearTimeout(activate_timeago_timeout);

  $('time[data-time-ago]').each(function() { 
    var $this = $(this); 
    if ($this.data('active') != 'yes') { 
      $this.timeago().data('active', 'yes');
    }
  });

  activate_timeago_timeout = setTimeout(activate_timeago, 60000);
}