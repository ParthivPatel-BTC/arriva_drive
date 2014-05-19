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
  $('.nano').nanoScroller({
    preventPageScrolling: true
  });
  $("#main").find('.description').load("readme.html", function(){
    setTimeout(function() {
        $(".nano").nanoScroller();
    }, 100);
  });
});