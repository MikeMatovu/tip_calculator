module TipsHelper
  def error_message_for(resource, field, id: nil)
    error_message = resource.errors[field].first || ""
    tag.span(error_message, class: "error-message", id: id)
  end

  def tip_buttons(tip_percentages, selected = nil)
    tip_percentages.map do |percent|
      tag.button("#{percent}%", type: "button", class: "tip-btn", data: { value: percent })
    end.join.html_safe
  end
end
