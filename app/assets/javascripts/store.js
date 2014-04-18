// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on("ready pagechange", function() {
	$(".store .entry").on("click", "img", function() {
		console.log("image clicked");
		$(this).closest(".entry").find("form").trigger("submit");
	});
});

