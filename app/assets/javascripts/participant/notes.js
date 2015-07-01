$(document).ready(function(){
  model_popup();
  $('#myStathalf2').circliful();

  $('.recentnote-slide').bxSlider({
    auto: true,
    controls:false
  });

  $( "#noteTabs" ).tabs();
  $(".note-panel").click(function(){
    $(".addnote-view").addClass("close")
  });

  $(".sharedtablist-box").on("click", function() {
    $(".sharedtablist-box").removeClass("active");
    $(".sharemain-panel").removeClass("activeLnk");
    $(this).addClass("active");
    $("div[id=" + $(this).attr("data-related") + "]").addClass("activeLnk");
  });

  $(".accord-toggle").click(function(){
    $(".accord-div").slideUp();
    if($(this).next('.accord-div').is(':visible')){
      $(this).next('.accord-div').slideUp();
      $(this).removeClass("active");
    }
    else{
      $(this).next('.accord-div').slideDown();
      $(this).addClass("active");
    }
    
    var owl = $('.owl-carousel');
    owl.owlCarousel({
      margin:0,
      autoWidth:true,
      nav:true,
      items:1,
      autoHeight:true
      
    });
    owl.on('mousewheel', '.owl-stage', function (e) {
      if (e.deltaY>0) {
        owl.trigger('next.owl');
      } else {
        owl.trigger('prev.owl');
      }
      e.preventDefault();
    });
  });

  $(".notepopuphead-back .back-btn").click(function(){
    $(".sharemain-panel").removeClass("activeLnk")
  });

  $('#tabs-2').on('click',function(){
    $('#note1').css('display','block');
  });

  $('#tabs-1').on('click',function(){
    $('#note1').css('display','block');
  });

});