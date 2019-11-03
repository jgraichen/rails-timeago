(function (factory) {
	if (typeof define === 'function' && define.amd) {
	  define(['jquery'], factory);
	} else if (typeof module === 'object' && typeof module.exports === 'object') {
	  factory(require('jquery'));
	} else {
	  factory(jQuery);
	}
  }(function (jQuery) {
	function numpf(n, a) {
	    return a[plural=n===0 ? 0 : n===1 ? 1 : n===2 ? 2 : n%100>=3 && n%100<=10 ? 3 : n%100>=11 ? 4 : 5];
	}
	// English shortened
	jQuery.timeago.settings.strings["ckb"] = {
		prefixAgo: null,
		prefixFromNow: "لەدوای",
		suffixAgo: "لەمەوبەر",
		suffixFromNow: null, // null OR "من الآن"
		second: function(value) { return numpf(value, [
		  'کەمتر لە چرکەیەک',
		   'یەکە چرکە',
		   'دوو چرکە',
		   '%d چرکە',
		   '%d چرکە',
		   '%d چرکە']); },
		seconds: function(value) { return numpf(value, [
		  'کەمتر لە چرکەیەک',
		   'چرکەیەک',
		   'دوو چرکە',
		   '%d چرکە',
		   '%d چرکە',
		   '%d چرکە']); },
		minute: function(value) { return numpf(value, [
		  'کەمتر لە خوولەکێک',
		   'خوولەکێک',
		   'دوو خوولەک',
		   '%d خوولەک',
		   '%d خوولەک',
		   'خوولەک']); },
		minutes: function(value) { return numpf(value, [
		  'کەمتر لە خوولەکێک',
		   'خوولەکێک',
		   'دوو خوولەک',
		   '%d خوولەک',
		   '%d خوولەک',
		   'خوولەک']); },
		hour:  function(value) { return numpf(value, [
		  'کەمتر لە کاتژمێر',
		   'کاتژمێرێک',
		   'دوو کاتژمێرێک',
		   '%d کاتژمێر',
		   '%d کاتژمێر',
		   '%d کاتژمێر']); },
		hours: function(value) { return numpf(value, [
		  'کەمتر لە کاتژمێرێک',
		   'کاتژمێرێک',
		   'دوو کاتژمێر',
		   '%d کاتژمێر',
		   '%d کاتژمێر',
		   '%d کاتژمێر']); },
		day:  function(value) { return numpf(value, [
		  'کەمتر لە ڕۆژێک',
		   'ڕۆژێک',
		   'دوو ڕۆژ',
		   '%d ڕۆژ',
		   '%d ڕۆژ',
		   '%d ڕۆژ']); },
		days: function(value) { return numpf(value, [
		  'کەمتر لە ڕۆژێک',
		   'ڕۆژێک',
		   'دوو ڕۆژ',
		   '%d ڕۆژ',
		   '%d ڕۆژ',
		   '%d ڕۆژ']); },
		month:  function(value) { return numpf(value, [
		  'کەمتر لە مانگێك',
		   'مانگێك',
		   'دوو مانگ',
		   '%d مانگ',
		   '%d مانگ',
		   '%d مانگ']); },
		months: function(value) { return numpf(value, [
		  'کەمتر لە مانگێك',
		   'مانگێك',
		   'دوو مانگ',
		   '%d مانگ',
		   '%d مانگ',
		   '%d مانگ']); },
		year:  function(value) { return numpf(value,  [
		  'کەمتر لە ساڵێک',
		   'ساڵێک',
		   '%d دوو ساڵ',
		   '%d ساڵ',
		   '%d ساڵ']);
		 },
		years: function(value) { return numpf(value,  [
		  'کەمتر لە ساڵێک',
		   'ساڵێک',
		   'دوو ساڵ',
		   '%d ساڵ',
		   '%d ساڵ',
		   '%d ساڵ']);}
	  };
  }));

