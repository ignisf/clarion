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

  def rating_label_color(rating)
    return nil if rating.nil?
    case rating.round
    when (0...3) then 'primary'
    when 3       then 'danger'
    when 4       then 'warning'
    when 5       then 'info'
    when 6       then 'success'
    end
  end

  def human_rating(rating)
    return nil if rating.nil?
    case rating.round
    when (0...3) then t('ratings.poor')
    when 3       then t('ratings.average')
    when 4       then t('ratings.good')
    when 5       then t('ratings.very_good')
    when 6       then t('ratings.excellent')
    end
  end

  def feedback_qr_code(event_id)
    RQRCode::QRCode.new(new_event_feedback_url(event_id: event_id), level: :l)
  end

  def feedback_qr_code_as_svg(event_id)
    feedback_qr_code(event_id).as_svg(shape_rendering: "crispEdges", module_size: 11, fill: "ffffff", offset: 10)
  end
end
