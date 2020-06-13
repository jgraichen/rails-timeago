//
// jQuery Timeago bootstrap for rails-timeago helper
//
//= require jquery.timeago

(function($) {
	var fn = function() {
		$('time[data-time-ago]').timeago();
	};
	$(fn);
	$(document).on('turbolinks:load page:load ajax:success ajaxSuccess', fn);
})(jQuery);
