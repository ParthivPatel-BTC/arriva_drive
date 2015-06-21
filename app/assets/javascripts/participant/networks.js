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
});