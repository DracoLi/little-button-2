$ ->
  $('.devise-registrations-new .user_email input').blur ->
    $input = $(@)
    $sublogo = $input.parents('.login').find('.sub-logo')
    email = $input.val()
    if email.length > 0 and $input.data('last-email') != email
      $sublogo.html ''
      $.get "/company-from-email?email=#{email}", (data) ->
        if data.name.length > 0
          $input.data 'last-email', email
          $sublogo.html "for #{data.name}"
          $sublogo.css({'opacity': 0, 'margin-left': '-6px'})
          $sublogo.animate({'opacity': 1, 'margin-left': 0})




