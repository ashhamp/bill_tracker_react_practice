
$(function(){ $(document).foundation();
  $("#main-sign-up").hover( function() {
    // highlight the mouseover target
    $(this).css("-webkit-filter", "blur(0px)");
  }, function() {
    $(this).css("-webkit-filter", "blur(3px)");
  });
  $("#logo").hover( function() {
    // highlight the mouseover target
    $(".circle-header").css("-webkit-filter", "blur(0px)");
  }, function() {
    $(".circle-header").css("-webkit-filter", "blur(15px)");
  });
});
