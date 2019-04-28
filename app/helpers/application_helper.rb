module ApplicationHelper
  def locale_collection
    I18n.available_locales.map do |locale|
      [t("locales.#{locale}"), locale]
    end
  end

  def proposition_status_class(status)
    {
      "undecided" => "default",
      "approved" => "info",
      "rejected" => "danger",
      "backup" => "warning",
    }.with_indifferent_access[status]
  end

  def proposition_status_glyph(status)
    {
      "undecided" => "question",
      "approved" => "thumbs-up",
      "rejected" => "thumbs-down",
      "backup" => "refresh",
    }.with_indifferent_access[status]
  end

  def proposition_status_icon(status)
    icon(proposition_status_glyph(status))
  end

  def action_buttons(conference, record, actions = [:index, :show, :edit, :destroy])
    klass = record.class
    output = ""

    if actions.include? :index
      output += link_to(icon(:list), [:management, conference, klass], {
        title: t("actions.index.button", models: klass.model_name.human(count: 2)),
        class: "btn btn-info",
      })
    end

    if actions.include? :show
      output += link_to(icon(:eye), [:management, conference, record], {
        title: t("actions.view.button", model: klass.model_name.human),
        class: "btn btn-info",
      })
    end

    if actions.include? :edit
      output += link_to(icon(:edit), [:edit, :management, conference, record], {
        title: t("actions.edit.button", model: klass.model_name.human),
        class: "btn btn-warning",
      })
    end

    if actions.include? :destroy
      output += link_to(icon(:trash), [:management, conference, record], {
        method: :delete,
        data: {confirm: t("actions.are_you_sure")},
        title: t("actions.destroy.button", model: klass.model_name.human),
        class: "btn btn-danger",
      })
    end

    output.html_safe
  end
end
