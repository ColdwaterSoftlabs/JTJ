$(function() {
  $(".btn").button({
    classes: {
      "ui-button": "no-border",
      "ui-state-default": "no-background"
    }
  }).click(function(e) {
    e.preventDefault();
    var widg = $(this).closest(".item-wrapper");
    widg.toggleClass("collapseed expanded");
    if (widg.hasClass("collapseed")) {
      $("#search").val("");
    }
  });
  var availableTags = [
    "ActionScript",
    "AppleScript",
    "Asp",
    "BASIC",
    "C",
    "C++",
    "Clojure",
    "COBOL",
    "ColdFusion",
    "Erlang",
    "Fortran",
    "Groovy",
    "Haskell",
    "Java",
    "JavaScript",
    "Lisp",
    "Perl",
    "PHP",
    "Python",
    "Ruby",
    "Scala",
    "Scheme"
  ];
  $("#search").autocomplete({
    source: availableTags
  });
  $("#search-form").submit(function(e) {
    e.preventDefault();
    // Do something with the Search value
  })
});
