$ ->
  $('#behaviourTagListingBtn, #participantTagListingBtn').click (e) ->
    e.preventDefault()
    $(this).closest('form').attr('action', $(this).attr('href')).submit()

  $('a[data-popup="true"]').bind "click", (e) ->
    window.open $(this).data("url"), "Popup" + $(this).data('id'), "height=600, width=600"
    e.preventDefault()
    return

  if $('#new-note-dialog-box').size() > 0
    openNewNoteDialogBox()

openNewNoteDialogBox = () ->
  $('#new-note-dialog-box').dialog
    resizable: false
    width: 400
    modal: true
    dialogClass: 'noTitleStuff'
    buttons:
      OK: ->
        $(this).dialog 'close'
