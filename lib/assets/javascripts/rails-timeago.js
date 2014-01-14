//
// jQuery Timeago bootstrap for rails-timeago helper
//
//= require jquery.timeago

(function($) {
	$(document).on('ready page:load', function() {
		$('time[data-time-ago]').timeago();
	});
})(jQuery);
