$(document).ready(function(){    
  $("#content-5, #content-4").mCustomScrollbar({
      axis:"x",
      theme:"dark-thin",
      autoExpandScrollbar:true,
      advanced:{autoExpandHorizontalScroll:true},
      scrollInertia:400
    });

  $('#all_behaviour').addClass('active');
  $('#myStathalf2').circliful();
  $('.recentnote-slide').bxSlider({
    auto: true,
    controls:false
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
  });  
  
  $(".filterIcon").click(function(){
    $(".activities-value").addClass("open");
  });
  $(".activiti-close").click(function(){
    $(".activities-value").removeClass("open");
  });

  //model_popup();
  $('.activitifilter-bottom a').on('click', function() {
    $(window).unbind("scroll");
    $(this).addClass('active').siblings().removeClass('active');
    var behaviour_id = $(".activitiesvalue").find("li.active a").attr("id");
    var activity_type = $(".activitifilter-bottom").find("a.active").attr("activity_type");
    if(typeof activity_type == 'undefined'){ activity_type = ''; }
    $.ajax({
    url: "/participants/activities?activity_type="+activity_type+"&behaviour_id="+behaviour_id,
    dataType: "script"
    });      
  });

  $('.activitiesvalue li a').on('click', function(){
    $(this).parent().addClass('active').siblings().removeClass('active');
    var activity_type = $(".activitifilter-bottom").find("a.active").attr("activity_type");
    if(typeof activity_type == 'undefined'){ activity_type = ''; }
    $.ajax({
    url: "/participants/activities?behaviour_id="+$(this).attr("id")+"&activity_type="+activity_type,
    dataType: "script"
    });
  });
});