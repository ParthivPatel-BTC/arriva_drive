$(document).ready ->
  $("a[id='alpha_search']").on "click", (e) ->
    $.ajax
      url: "/participants/networks?alpha_character=" + $(this).text()
      dataType: "script"
    return
  return