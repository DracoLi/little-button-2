module BootstrapFlashHelper
  ALERT_TYPES = [:info, :success, :warning, :danger]

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = :success if type == :sucess || type == :notice
      type = :info    if type == :notice || type == :info
      type = :danger  if type == :alert || type == :error
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div,
                           content_tag(:div,
                            content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") + msg.html_safe, :class => 'container'),
                           :class => "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end
end
