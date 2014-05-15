$ ->
  $("#participant_year_started").datepicker
    format: "yyyy"
    viewMode: "years"
    minViewMode: "years"
  return

@readURL = (input, previewContainerSelector) ->
  if input.files and input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      $(previewContainerSelector).attr("src", e.target.result).width(100).height('auto').show()

    reader.readAsDataURL input.files[0]
    $('#existingEventImage').hide()

# Count the characters in input field and update the target Div with this count
@countAndUpdateCharCount = (inputFieldSelector, targetDiv) ->
  count = inputFieldSelector.val().length
  targetDiv.text(count+'/'+inputFieldSelector.attr('maxlength'))
