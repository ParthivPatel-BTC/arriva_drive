$(document).ready ->
  $("input#behaviour[type=checkbox]").on "change", ->
    $("ul #behaviour_checkboxes input").each ->
      uniformChkBoxChecked $(this)
      return

    uniformChkBoxChecked_current $(this)
    return

  return

uniformChkBoxChecked = undefined
uniformChkBoxChecked = (selector) ->
  selector.attr "checked", false
  selector.parent().removeClass "checked"
  $.uniform.update()
  selector.parent().removeClass "checked"
  return

uniformChkBoxChecked_current = undefined
uniformChkBoxChecked_current = (selector) ->
  selector.attr "checked", true
  selector.parent().addClass "checked"
  $.uniform.update()
  selector.parent().addClass "checked"
  return