require File.dirname(__FILE__) + '/test_helper'

class SinatraPrawnTest < Test::Unit::TestCase
  include Sinatra::Test

  def prawn_app(&block)
    mock_app {
      helpers Sinatra::Prawn
      set :views, File.dirname(__FILE__) + '/views'
      get '/', &block
    }
    get '/'
  end

  def test_renders_inline_strings
    prawn_app { prawn 'pdf.text "Hello shrimp!"' }
    assert ok?
    text = PDF::TextInspector.analyze(body)
    assert_equal "Hello shrimp!", text.strings.first
  end

  def test_renders_inline_blocks
    prawn_app {
      @name = "Frank & Mary"
      prawn do |pdf|
        pdf.text "Hello #{@name}!"
      end
    }
    assert ok?
    text = PDF::TextInspector.analyze(body)
    assert_equal "Hello Frank & Mary!", text.strings.first
  end

  def test_renders_prawn_files_in_views_path
    prawn_app {
      @name = "World"
      prawn :hello
    }
    assert ok?
    text = PDF::TextInspector.analyze(body)
    assert_equal "Hello, World!", text.strings.first
  end
  
  def test_raises_error_if_template_not_found
    mock_app {
      helpers Sinatra::Prawn
      get('/') { prawn :no_such_template }
    }
    assert_raise(Errno::ENOENT) { get('/') }
  end
end
