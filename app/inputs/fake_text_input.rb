class FakeTextInput < SimpleForm::Inputs::StringInput
  # This method only create a basic input without reading any value from object
  def input
    value = input_html_options[:value]
    template.text_area_tag(attribute_name, value, input_html_options)
  end
end
