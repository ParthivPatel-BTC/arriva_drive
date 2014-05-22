function ShowHide(ObjID) {
    $("#defult1").removeAttr("class");
    $("#defult2").removeAttr("class");
    $("#defult3").removeAttr("class");
    $("#defult4").removeAttr("class");
    $("#defult5").removeAttr("class");
    $("#defult6").removeAttr("class");
$("#defult7").removeAttr("class");
$("#defult8").removeAttr("class");
$("#defult9").removeAttr("class");
$("#defult10").removeAttr("class");

$("#values1").hide();
$("#values2").hide();
$("#values3").hide();
$("#values4").hide();
$("#values5").hide();
$("#customerorientation").hide();



    $("#defult1").addClass("circulbox circulcolordefult");
    $("#defult2").addClass("circulbox circulcolordefult");
    $("#defult3").addClass("circulbox circulcolordefult");
    $("#defult4").addClass("circulbox circulcolordefult");
    $("#defult5").addClass("circulbox circulcolordefult");
    $("#defult6").addClass("circulbox circulcolordefult");
$("#defult7").addClass("circulbox circulcolordefult");
$("#defult8").addClass("circulbox circulcolordefult");
$("#defult9").addClass("circulbox circulcolordefult");
$("#defult10").addClass("circulbox circulcolordefult");

    if (ObjID == 'circulcolor1') {
        $("#defult1").removeAttr("class");
$("#defult2").removeAttr("class");
$("#defult4").removeAttr("class");
        $("#defult7").removeAttr("class");
        $("#defult9").removeAttr("class");
$("#values1").show();

        $("#defult1").addClass("circulbox circulcolor1");
$("#defult2").addClass("circulbox circulcolor1");
$("#defult4").addClass("circulbox circulcolor1");
        $("#defult7").addClass("circulbox circulcolor1");
        $("#defult9").addClass("circulbox circulcolor1");
    }
    else if (ObjID == 'circulcolor2') {
        $("#defult1").removeAttr("class");
        $("#defult3").removeAttr("class");
        $("#defult4").removeAttr("class");
$("#defult5").removeAttr("class");
$("#defult8").removeAttr("class");
$("#defult10").removeAttr("class");
$("#values2").show();

        $("#defult1").addClass("circulbox circulcolor2");
        $("#defult3").addClass("circulbox circulcolor2");
        $("#defult4").addClass("circulbox circulcolor2");
$("#defult5").addClass("circulbox circulcolor2");
$("#defult8").addClass("circulbox circulcolor2");
$("#defult10").addClass("circulbox circulcolor2");
    }
    else if (ObjID == 'circulcolor3') {
        $("#defult1").removeAttr("class");
        $("#defult3").removeAttr("class");
        $("#defult4").removeAttr("class");
$("#defult6").removeAttr("class");
$("#defult7").removeAttr("class");
$("#defult8").removeAttr("class");
$("#defult10").removeAttr("class");
$("#values3").show();

        $("#defult1").addClass("circulbox circulcolor3");
        $("#defult3").addClass("circulbox circulcolor3");
$("#defult4").addClass("circulbox circulcolor3");
        $("#defult6").addClass("circulbox circulcolor3");
$("#defult7").addClass("circulbox circulcolor3");
        $("#defult8").addClass("circulbox circulcolor3");
$("#defult10").addClass("circulbox circulcolor3");
    }
else if (ObjID == 'circulcolor4') {
        $("#defult2").removeAttr("class");
$("#defult3").removeAttr("class");
        $("#defult4").removeAttr("class");
$("#defult5").removeAttr("class");
        $("#defult6").removeAttr("class");
$("#defult9").removeAttr("class");
$("#values4").show();

        $("#defult2").addClass("circulbox circulcolor4");
$("#defult3").addClass("circulbox circulcolor4");
        $("#defult4").addClass("circulbox circulcolor4");
$("#defult5").addClass("circulbox circulcolor4");
$("#defult6").addClass("circulbox circulcolor4");
        $("#defult9").addClass("circulbox circulcolor4");
    }
else if (ObjID == 'circulcolor5') {
$("#defult3").removeAttr("class");
        $("#defult4").removeAttr("class");
        $("#defult5").removeAttr("class");
$("#defult7").removeAttr("class");
$("#defult9").removeAttr("class");
$("#defult10").removeAttr("class");
$("#values5").show();

        $("#defult3").addClass("circulbox circulcolor5");
        $("#defult4").addClass("circulbox circulcolor5");
        $("#defult5").addClass("circulbox circulcolor5");
$("#defult7").addClass("circulbox circulcolor5");
$("#defult9").addClass("circulbox circulcolor5");
$("#defult10").addClass("circulbox circulcolor5");
    }
}
