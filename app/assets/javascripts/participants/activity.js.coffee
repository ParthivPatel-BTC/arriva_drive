$ ->
  uniformChkBoxChecked($('.correct-answer-chkbox'))

  $("input[name='activity[answer]']").click ->
    sendAnswerSelectionAjax($(this)) # unless $(this).is(':disabled')

uniformChkBoxChecked = (selector) ->
  selector.attr('disabled',false)
  selector.attr('checked',true)
  selector.parent().addClass('checked')
  $.uniform.update();
  selector.attr('disabled',true)
  selector.parent().addClass('checked')

sendAnswerSelectionAjax = (answerSelector) ->
  ajax_data =
    answer_id: answerSelector.val()
  sendAjax('POST', '/participants/activities/'+$('#activity_id').val()+'/answer_question', ajax_data)

sendAjax = (type, url, data) ->
  $.ajax
    type: type
    beforeSend: (xhr) ->
      xhr.setRequestHeader "X-CSRF-Token", $("meta[name=\"csrf-token\"]").attr("content")
    url: url
    data: data

@answerQuestionPopUp = (msg) ->
  $('#answer-popup-msg').text(msg)
  $('#answer-dialog-box').dialog
    resizable: false
    width: 400
    modal: true
    dialogClass: 'noTitleStuff'
    buttons:
      OK: ->
        $(this).dialog 'close'
    close: (event, ui) ->
      window.location.href = '/participants/activities/'+$('#activity_id').val()
