$ ->
  # =========================== Event add/edit page
  $('#eventFormDatePicker').datepicker
    format: 'dd/mm/yyyy'

  # For previewing image before upload.
  $("#event_image").change ->
    readURL $(this)[0], "#previewEventImage"

  # Binding keyup for showing number of characters entered in field
  $('#eventDescTextField').keyup ->
    countAndUpdateCharCount($(this), $('#eventDescSubText'))

  # For Event Start Time
  $("#timepicker1").timepicker(
    defaultTime: '09:00 AM'
    minuteStep: 1
    showSeconds: true
    showMeridian: false
  ).next().on ace.click_event, ->
    $(this).prev().focus()
    return

  # For Event End Time
  $("#timepicker2").timepicker(
    minuteStep: 1
    showSeconds: true
    showMeridian: false
  ).next().on ace.click_event, ->
    $(this).prev().focus()
    return

