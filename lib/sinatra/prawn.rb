require 'sinatra/base'

module Sinatra
  module Prawn
    # Generate pdf file using Prawn.
    # Takes the name of a template to render as a Symbol and returns a String with the rendered output.
    #
    # Options for prawn may be specified in Sinatra using set :prawn, { ... }
    def prawn(template=nil, options={}, &block)
      require 'prawn' unless defined? ::Prawn
      options, template = template, nil if template.is_a?(Hash)
      template = lambda { block } if template.nil?
      options[:layout] = false
      options[:options] ||= self.class.prawn if self.class.respond_to? :prawn
      render :prawn, template, options
    end

  protected
    def render_prawn(template, data, options, &block)
      pdf = ::Prawn::Document.new(options[:options] || {})
      if data.respond_to?(:to_str)
        eval data.to_str, binding, '<PRAWN>', 1
      elsif data.kind_of?(Proc)
        data.call(pdf)
      end
      pdf.render
    end
  end

  helpers Prawn
end
