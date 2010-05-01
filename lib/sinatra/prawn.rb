require 'sinatra/base'

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
  end

  helpers Prawn
end


module Tilt
  class PrawnTemplate < Template
    def initialize_engine
       return if defined? ::Prawn::Document
       require_template_library 'prawn'
       require_template_library 'prawn/layout'
     end

     def prepare
     end

    def evaluate(scope, locals, &block)
      pdf = ::Prawn::Document.new
      if data.respond_to?(:to_str)
        locals[:pdf] = pdf
        super(scope, locals, &block)
      elsif data.kind_of?(Proc)
        data.call(pdf)
      end
      pdf.render
    end

    def precompiled_template(locals)
      data.to_str
    end
 end
 register 'prawn', PrawnTemplate
end