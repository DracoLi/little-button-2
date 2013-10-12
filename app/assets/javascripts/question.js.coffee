window.LilButton ||= {}
window.LilButton.Questions =

  updateQuestionList: (data) ->
    $('#questionsList .list').empty()
    for quesData in data
      @addQuestion(quesData)

    options =
      valueNames: ['the-question', 'answered']
    @questionsList = new List('questionsList', options)

  addQuestion: (questionData) ->
    # Convert percentage float into string
    questionData['answered_p'] *= 100
    questionData['answered_p'] = Math.round(questionData['answered_p'])
    questionHTML = HandlebarsTemplates['question-row'](questionData)

    # Prepend question to list
    $(questionHTML).prependTo $('#questionsList .list')
