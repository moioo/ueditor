module Ueditor
  module Helper
    def ueditor_tag(name, content = nil, options = {})
      id = sanitize_to_id(name)
      input_html = { :id => id }.merge(options.delete(:input_html) || {})
      output = ActiveSupport::SafeBuffer.new
      #output << javascript_include_tag("#{RailsUeditor::assets_cdn}ueditor/ueditor.all.v3.min.js")
      output << text_area_tag(name, content, input_html)
      output << javascript_tag(js_replace(id, options))
    end
    
    def ueditor(name, method, options = {})
      input_html = (options.delete(:input_html) || {}).stringify_keys
      output_buffer = ActiveSupport::SafeBuffer.new
      #output_buffer << javascript_include_tag("#{RailsUeditor::assets_cdn}ueditor/ueditor.all.v3.min.js")
      output_buffer << build_text_area_tag(name, method, self, options, input_html)
      output_buffer << javascript_tag(js_replace(input_html['id'], options))
    end

    def ueditor_image_tag(_name, _onUploadComplate, _onClick, require_javascript = true)
      output_buffer = ActiveSupport::SafeBuffer.new
      #output_buffer << javascript_include_tag("#{RailsUeditor::assets_cdn}ueditor/ueditor.all.v3.min.js") if require_javascript
      output_buffer << javascript_tag( nil, :type => 'text/plain', :id => _name)
      output_buffer << javascript_tag("var #{_name} = UE.getEditor('#{_name}');#{_name}.ready(function(){#{_name}.hide();#{_name}.addListener('beforeinsertimage', #{_onUploadComplate})});function #{_onClick}(){var myImage = #{_name}.getDialog('insertimage');myImage.open();}")
      output_buffer
    end
        
    private
    
    def js_replace(dom_id, options = {})
      editor_id = options[:editor_id].nil? ? 'editor' : "#{options[:editor_id].to_s.downcase} "
      "var #{editor_id} = new UE.ui.Editor();#{editor_id}.render('#{dom_id}')"
    end
    
    def build_text_area_tag(name, method, template, options, input_html)
      if Rails.version >= '4.0.0'
        text_area_tag = ActionView::Helpers::Tags::TextArea.new(name, method, template, options)
        text_area_tag.send(:add_default_name_and_id, input_html)
        text_area_tag.render
      else
        raise 'Please upgrade your Rails !'
      end
    end
  end
  
  module Builder
    def ueditor(method, options = {})
      @template.send("ueditor", @object_name, method, objectify_options(options))
    end
  end
end