uniformChkBoxChecked = undefined
uniformChkBoxChecked_current = undefined
$(document).ready ->
  $("input#behaviour[type=checkbox]").on "change", ->
    if this.checked
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
  selector.prop "checked", true
  $.uniform.update()
  return