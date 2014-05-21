$(document).ready ->
  $("input#behaviour[type=checkbox]").on "change", ->
    checkedBehaviours = $("input#behaviour:checked").map(->
      $(this).val()
    ).get().join(",")
    $.ajax
      url: "/participants/activities?behaviour_id=" + checkedBehaviours
      dataType: "script"
    return
  return