require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      controller_name = self.class.name.underscore
      p ("views/#{controller_name}/#{template_name}.html.erb")
      template = File.open("views/#{controller_name}/#{template_name}.html.erb") do |f|
         ERB.new(f.read).result(binding)
      end

      render_content(template, "text/html")
    end


  end
end
