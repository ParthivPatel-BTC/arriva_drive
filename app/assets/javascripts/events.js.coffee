$ ->
  # =========================== Event add/edit page
  $('#eventFormDatePicker').datepicker
    format: 'dd/mm/yyyy'

  # For previewing image before upload.
  $("#event_image").change ->
    readURL $(this)[0], "#previewEventImage"

readURL = (input, previewContainerSelector) ->
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      $(previewContainerSelector).attr("src", e.target.result).width(100).height('auto').show()

    reader.readAsDataURL input.files[0]
    $('#existingEventImage').hide()