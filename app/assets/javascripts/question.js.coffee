window.LilButton ||= {}
window.LilButton.Questions =

  updateQuestionList: (data) ->
    $('.questions-list').empty()
    for quesData in data
      @addQuestion(quesData)

  addQuestion: (questionData) ->
    # Convert percentage float into string
    questionData['answered_p'] *= 100
    questionHTML = HandlebarsTemplates['question-row'](questionData)

    # Prepend question to list
    $(questionHTML).prependTo $('.questions-list')
