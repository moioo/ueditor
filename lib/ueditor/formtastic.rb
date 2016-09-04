require "formtastic"

class Ueditor
  include ::Formtastic::Inputs::Base
  
  def to_html
    input_wrapping do
      label_html <<
      builder.ueditor(method, input_html_options)
    end
  end
end
