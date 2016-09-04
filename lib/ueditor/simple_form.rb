module Ueditor
  module SimpleForm
    class UeditorInput < ::SimpleForm::Inputs::Base
      def input(wrapper_options)
        @builder.ueditor(attribute_name, input_html_options)
      end
    end
  end
end

::SimpleForm::FormBuilder.map_type :ueditor, :to => Ueditor::SimpleForm::UeditorInput