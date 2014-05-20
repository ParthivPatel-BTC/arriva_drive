$(document).ready(function() {
  $('.right, .left').on( "click", function(e) {
    e.preventDefault();
    if ($(this).attr("href").split("page").length > 1) {
      var pageNum = $(this).attr("href").match(/page=([0-9]+)/)[1];
    }
    else {
      var pageNum = '1';
    }
    $.ajax({
      url: "/participants/activities?page="+pageNum,
      dataType: "script"
    });
  });
});