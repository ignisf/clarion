module ApplicationHelper
  def action_buttons(record, actions = [:index, :show, :edit, :destroy])
    klass = record.class
    output = ''

    if actions.include? :index
      output += link_to(icon(:list), [:management, klass], {
        title: t('actions.index.button', models: klass.model_name.human(count: 2)),
        class: 'btn btn-info'
      })
    end

    if actions.include? :show
      output += link_to(icon(:eye), [:management, record], {
        title: t('actions.view.button', model: klass.model_name.human),
        class: 'btn btn-info'
      })
    end

    if actions.include? :edit
    output += link_to(icon(:edit), [:edit, :management, record], {
      title: t('actions.edit.button', model: klass.model_name.human),
      class: 'btn btn-primary'
    })
    end

    if actions.include? :destroy
    output += link_to(icon(:trash), [:management, record], {
      method: :delete,
      data: {confirm: t('actions.are_you_sure')},
      title: t('actions.edit.button', model: klass.model_name.human),
      class: 'btn btn-danger'
    })
    end

    output.html_safe
  end
end
