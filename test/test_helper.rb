require 'rubygems'
require 'test/unit'
require 'rack/test'

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'sinatra/prawn'

require "pdf/reader"

module PDF
  class TextInspector
    attr_accessor :font_settings, :size, :strings

    def initialize
      @font_settings = []
      @fonts = {}
      @strings = []
    end

    def resource_font(*params)
      @fonts[params[0]] = params[1].basefont
    end

    def set_text_font_and_size(*params)
      @font_settings << { :name => @fonts[params[0]], :size => params[1] }
    end

    def show_text(*params)
      @strings << params[0]
    end

    def show_text_with_positioning(*params)
      # ignore kerning information
      @strings << params[0].reject { |e| Numeric === e }.join
    end

    def self.analyze(output,*args,&block)
      obs = self.new(*args, &block)
      PDF::Reader.string(output,obs)
      obs
    end

    def self.analyze_file(filename,*args,&block)
      analyze(File.open(filename, "rb") { |f| f.read },*args,&block)
    end

    def self.parse(obj)
      PDF::Reader::Parser.new(
        PDF::Reader::Buffer.new(StringIO.new(obj)), nil).parse_token
    end
  end
end

class Test::Unit::TestCase
  include Rack::Test::Methods

  attr_reader :app

  # Sets up a Sinatra::Base subclass defined with the block
  # given. Used in setup or individual spec methods to establish
  # the application.
  def mock_app(base=Sinatra::Base, &block)
    @app = Sinatra.new(base, &block)
  end
end
