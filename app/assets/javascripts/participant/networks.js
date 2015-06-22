$(document).ready(function(){
  $("#content-5, #content-4").mCustomScrollbar({
    axis:"x",
    theme:"dark-thin",
    autoExpandScrollbar:true,
    advanced:{autoExpandHorizontalScroll:true},
    scrollInertia:400
  });  
  var owl = $('.owl-carousel');
  owl.owlCarousel({
    margin:0,
    autoWidth:false,
    nav:true,
    items:8,
    responsive:{
      320:{
        autoWidth:true,
        items:4
      },
      600:{
        autoWidth:true,
        items:12
      },
      1000:{
        items:14
      },
      1600:{
        items:18
      }
    }
  });
  owl.on('mousewheel', '.owl-stage', function (e) {
    if (e.deltaY>0) {
      owl.trigger('next.owl');
    } else {
      owl.trigger('prev.owl');
    }
    e.preventDefault();
  });
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
  
  
  $(".participantslist li").click(function(){
    $(this).toggleClass("active")
  });
    
    
  $(".accord-toggle").click(function(){
    $(".accord-div").slideUp();
    $(this).next('.accord-div').slideDown();
    
    $(".mouseWheelButtons .carousel2").jCarouselLite({
      btnNext: ".mouseWheelButtons .next",
      btnPrev: ".mouseWheelButtons .prev",
      mouseWheel: true,
      visible: 6,
      circular: false
      
    });
  });
});