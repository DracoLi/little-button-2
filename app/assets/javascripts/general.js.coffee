window.LilButton ||= {}
window.LilButton.General =

  initializeScheduleForms: ->
    that = @

    # Initialize existing schedule forms
    $('.schedule-form .time input[type="text"]').mask('99:99')
    $('.schedule-form').each ->
      $form = $(@)
      frequency = $form.find('.frequency .active').text().trim()
      that.update_day_with_frequency($form, frequency)

    # Handle frequency changes for schedule forms
    $('.schedule-form .frequency input[name="scheduled_time[frequency]"]').change ->
      $scheduleForm = $(@).parents('.schedule-form')
      new_frequency = $(@).val()
      that.update_day_with_frequency($scheduleForm, new_frequency)

  update_day_with_frequency: ($form, frequency) ->
    $select = $form.find('.scheduled-day')
    dayValue = $select.data('value')

    # Remove previous select options
    $form.find('.chosen-container').remove()
    $select.empty()

    # Add in new options
    if frequency == 'Daily'
      $select.attr('disabled', 'disabled')
      $select.show()
    else if frequency == 'Weekly' or frequency == 'Monthly'
      $select.removeAttr('disabled')

      # Get new option values
      if frequency == 'Weekly'
        values = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
      else if frequency == 'Monthly'
        values = [1..31]

      # Add in new options
      hasValue = false
      $.each values, (index, value) ->
        $option = $("<option value=\"#{value}\">#{value}</option>")
        if dayValue == value
          $option.attr('selected', 'selected')
          hasValue = true
        $select.append $option

      # Select first value by default if no targeted value
      if not hasValue
        $select.find('option').first().attr('checked', 'checked')


    # Append the new select and enable chosen on it
    $another = $select.clone()
    $select.after $another
    $select.remove()
    $another.chosen({width: '164px', disable_search_threshold: 10})

$ ->
  # Global alerts
  $('.global-alerts button.close').click ->
    $(@).parents('.alert').remove()

  window.LilButton.General.initializeScheduleForms()

  # Sign in sign up verticle align
  $login = $('.login')
  $login.css
    'margin-top': -$login.height() / 2.0
