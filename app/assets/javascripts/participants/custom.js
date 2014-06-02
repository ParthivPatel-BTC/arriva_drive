$(function () {
        $("select, input, button").uniform();
    });

$(document).ready(function () {
        $("#youtube").modalbox({
            Type: 'iframe',
            Width: 560,
            Height: 315
        });
    });
$(function(){
  $(window).load(function () {
    $('.nano').nanoScroller({
      preventPageScrolling: true
    });
  });
  $("#main").find('.description').load("readme.html", function(){
    setTimeout(function() {
        $(".nano").nanoScroller();
    }, 100);
  });

  $(".circulbox").click(function(){
    var panel = $(this).children(".circulplus");
    if($(panel).is(':hidden'))
    {
      $(".circulplus").hide();
      $(panel).show();
    }
    else
    {
      $(".circulplus").hide();
    }
  });
});