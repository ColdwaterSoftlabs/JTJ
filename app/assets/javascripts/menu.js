function menu(){
	$('.nav').append($('<div class = "menuopen" ></div>'));
	//$('.nav-item').has('ul').prepend('<span class="nav-click"></span>');
   
	$(".menuopen").on("click", function() {
	  $('.nav-list').toggle();
	  $(this).css("display", "none");
	  $(".menuclose").css("display", "block");
	  //$('html,body').animate({scrollTop: 0}, 0);
	  //$('.navbar-fixed-top').css("position", 'absolute');
	  $('.nav-list').css("display", "block");
	});

	$(".menuclose").on("click", function() {
	  $(this).css("display", "none");
	  $(".menuopen").css("display", "block");
	  //$('.navbar-fixed-top').css("position", 'fixed');
	  $('.nav-list').css("display", "none");
	});

	
}
$(document).ready(function(){
	menu();
});

