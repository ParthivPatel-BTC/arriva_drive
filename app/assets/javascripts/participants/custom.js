$(function () {
        $("select, input, button").uniform();
    });

$(document).ready(function () {
        $("#youtube").modalbox({
            Type: 'iframe',
            Width: 560,
            Height: 315
        });
        $(".inline").modalbox({
                Type: 'inline',
                Width: 500,
                Height: 310,
                ShowClose: false,
                CloseHandle: $(".inlineclose"),
                OnInit: function () { console && console.log("Inline Modalbox initialized"); },
                OnShow: function (index) { $(".inlineclosetopbtn").tooltip({ Position: 'left' }); $(".inlineclosebtn").tooltip({ Position: 'top' }); },
                OnClose: function () { console && console.log("Inline Modalbox closed"); }
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
});