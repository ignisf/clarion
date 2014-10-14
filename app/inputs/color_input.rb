class ColorInput < SimpleForm::Inputs::Base
  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    @builder.color_field(attribute_name, merged_input_options)
  end
end
