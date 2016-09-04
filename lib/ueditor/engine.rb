module Ueditor
  class Engine < ::Rails::Engine
    initializer "ueditor.simple_form_and_formtastic" do
      require "ueditor/simple_form" if Object.const_defined?("SimpleForm")
      require "ueditor/formtastic" if Object.const_defined?("Formtastic")
    end
    
    initializer "ueditor.helper_and_builder" do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send(:include, Ueditor::Helper)
        ActionView::Helpers::FormBuilder.send(:include, Ueditor::Builder)
      end
    end
  end
end
