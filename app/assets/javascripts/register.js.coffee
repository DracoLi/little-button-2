$ ->
  $('.devise-registrations-new .user_email input').blur ->
    $input = $(@)
    $sublogo = $input.parents('.login').find('.sub-logo')
    $sublogo.html ''
    email = $input.val()
    if email.length > 0
      $.get "/company-from-email?email=#{email}", (data) ->
        if data.name.length > 0
          $sublogo.html "for #{data.name}"
          $sublogo.css({'opacity': 0, 'margin-left': '-6px'})
          $sublogo.animate({'opacity': 1, 'margin-left': 0})




