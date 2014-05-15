# For previewing image before upload.
readURL = (input, previewContainerSelector) ->
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      $(previewContainerSelector).attr("src", e.target.result).width(250).height 150
      return
    reader.readAsDataURL input.files[0]
  return
$(document).ready ->
  $("#participant_photo").change ->
    readURL $(this)[0], "#preview_participant_photo"
    return

  $('#participantperformanceSummaryInput').keyup ->
    countAndUpdateCharCount($(this), $('#participantperformanceSummarySubText'))
