Paloma.callbacks['questions']['show'] = (params) ->

  # Initialize question page answers list
  if $('#questionAnswers .list').length > 0
    new List('questionAnswers', {valueNames: ['answer-user']})

  # Edit button
  $('.questions-show .myanswer .edit-myanswer a').click (e) ->
    e.preventDefault()
    $(@).parents('.myanswer-view').addClass('hidden')
    $('.myanswer-edit').removeClass('hidden')
    $('.myanswer-edit textarea')
      .focus()
      .val($('.myanswer-view .myanswer-text').html())
