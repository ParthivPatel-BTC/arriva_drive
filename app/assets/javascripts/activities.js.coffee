$ ->
  # =========================== Activity add/edit page
  # For helper text showing number of characters entered in field
  $('#activityDescTextField').keyup ->
    countAndUpdateCharCount($(this), $('#activityDescSubText'))
  $('#mcqQuestionTextArea').keyup ->
    countAndUpdateCharCount($(this), $('#mcqQuestionSubText'))
  $('.mcqAnsTextField').keyup ->
    countAndUpdateCharCount($(this), $(this).next())
