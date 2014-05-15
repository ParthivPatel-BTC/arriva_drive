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
