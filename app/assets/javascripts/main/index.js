// ===== Scroll to Top ==== 

$(window).scroll(function() {
    if ($(this).scrollTop() >= 50) {        // If page is scrolled more than 50px
        $('#return-to-top').fadeIn(200);    // Fade in the arrow
    } else {
        $('#return-to-top').fadeOut(200);   // Else fade out the arrow
    }
});

$('#return-to-top').click(function() {      // When arrow is clicked
    $('body,html').animate({
        scrollTop : 0                       // Scroll to top of body
    }, 500);
});

// ===== Scroll to Top ==== 

$(window).scroll(function() {
    if ($(this).scrollTop() >= 50) {        // If page is scrolled more than 50px
        $('#return-to-top1').fadeIn(200);    // Fade in the arrow
    } else {
        $('#return-to-top1').fadeOut(200);   // Else fade out the arrow
    }
});

$('#return-to-top1').click(function() {      // When arrow is clicked
    $('body,html').animate({
        scrollTop : 0                       // Scroll to top of body
    }, 500);
});

$(".signup-menu").on('click', function() {
   $('body').animate({scrollTop: 0}, 500);
    $(".signup-popup").show();
  });

 $(".missout-rem-close").on('click', function() {
    var current = $(this);
    var parent = current.data('parent');
    var open = current.data('open');
    $(parent).hide();
    $(open).show();
  });

  $('.icon').click(function() {
    $('.search').toggle();
   });

  $(document).ready(function () {
       $(window).scroll(function () {
           if ($(this).scrollTop() > 600) {
               $('.float-icon').fadeIn();
           } else {
               $('.float-icon').fadeOut();
           }
       });
  });
