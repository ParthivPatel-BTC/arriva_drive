$(document).ready(function(){
  model_popup();
  $('#myStathalf2').circliful();
  
  $('.recentnote-slide').bxSlider({
    auto: true,
    controls:false
  });
  
  $( "#filepaneltab" ).tabs();
  $(".file-panel").click(function(){
    $(".addnote-view").addClass("close")
  });
  
  $(".sharedtablist-box").on("click", function() {
    $(".sharedtablist-box").removeClass("active");
    $(".sharemain-panel").removeClass("activeLnk");
    $(this).addClass("active");
    $("div[id=" + $(this).attr("data-related") + "]").addClass("activeLnk");
  });
  
  
  $("#toggle1").click(function(){
    $("#div1").slideUp();
    if($(this).next('#div1').is(':visible')){
      $(this).next('#div1').slideUp();
      $(this).removeClass("active");
    }
    else{
      $(this).next('#div1').slideDown();
      $(this).addClass("active");
    }
    
    var owl1 = $('#owl1');
    owl1.owlCarousel({
      margin:0,
      autoWidth:true,
      nav:true,
      items:1,
      autoHeight:true
      
    });
    owl1.on('mousewheel', '#owl1.owl-stage', function (e) {
      if (e.deltaY>0) {
        owl1.trigger('next.owl');
      } else {
        owl1.trigger('prev.owl');
      }
      e.preventDefault();
    });
    
    owl1.data('owlCarousel').refresh();
  });
  
  $('#participant_attachment_id').on( "click", function() {
    $('#participant_attachments_attachment').trigger( "click" );
  });

  $('.custom-toggle').on('click', function(){
   parentObj = $(this).parent();
   customCarousel = parentObj.find('.custom-carousel');
   tagsameoneDetailObj = parentObj.find('.tagsameone-detail');

    if(tagsameoneDetailObj.is(':visible')){
      tagsameoneDetailObj.slideUp();
      $(this).removeClass("active");
    }
    else{
      tagsameoneDetailObj.slideDown();
      $(this).addClass("active");
    }

    customCarousel.owlCarousel({
      margin:0,
      autoWidth: true,
      nav:true,
      items:1,
      autoHeight: true
    });
  
    customCarousel.on('mousewheel', "customCarousel.owl-stage", function (e1) {
    if (e1.deltaY>0) {
      customCarousel.trigger('next.owl');
    } else {
      customCarousel.trigger('prev.owl');
    }
    e1.preventDefault();
    });
  });
});
