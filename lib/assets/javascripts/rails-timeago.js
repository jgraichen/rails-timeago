//
// jQuery Timeago bootstrap for rails-timeago helper
//
//= require jquery.timeago

(function($) {
	$(document).on('ready turbolinks:load page:load ajax:success', function() {
		$('time[data-time-ago]').timeago();
	});
})(jQuery);
