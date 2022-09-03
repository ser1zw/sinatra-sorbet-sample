# typed: true
require 'test/unit'
require 'rack/test'
require_relative '../app'

class AppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    App
  end

  def test_50
    get '/50'
    assert last_response.ok?
  end

  def test_51
    get '/51'
    assert_false last_response.ok?
  end
end
