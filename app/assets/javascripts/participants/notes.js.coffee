$ ->
  $('#behaviourTagListingBtn, #participantTagListingBtn').click (e) ->
    e.preventDefault()
    $(this).closest('form').attr('action', $(this).attr('href')).submit()
