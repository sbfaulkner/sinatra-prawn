require 'sinatra/base'
require 'prawn'

module Sinatra
  module Prawn
    # Generate pdf file using Prawn.
    # Takes the name of a template to render as a Symbol and returns a String with the rendered output.
    #
    # Options for prawn may be specified in Sinatra using set :prawn, { ... }
    def prawn(template=nil, options={}, locals = {}, &block)
      options, template = template, nil if template.is_a?(Hash)
      template = lambda { block } if template.nil?
      options[:layout] = false
      render :prawn, template, options, locals
    end

  protected
    def render_prawn(template, data, options, locals, &block)
      filename = options.delete(:filename) || '<PRAWN>'
      line = options.delete(:line) || 1
      pdf = ::Prawn::Document.new(options)
      if data.respond_to?(:to_str)
        eval data.to_str, binding, filename, line
      elsif data.kind_of?(Proc)
        data.call(pdf)
      end
      pdf.render
    end
  end

  helpers Prawn
end
