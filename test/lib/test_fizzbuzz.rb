# typed: true
require 'test/unit'
require_relative '../../lib/fizzbuzz'

class FizzBuzzTest < Test::Unit::TestCase
  def test_fizzbuzz
    fizzbuzz = FizzBuzz.new(15)
    ret = fizzbuzz.run

    assert_equal(15, ret.size)
    assert_equal(1, ret[0])
    assert_equal('Fizz', ret[2])
    assert_equal('Buzz', ret[4])
    assert_equal('FizzBuzz', ret[14])
  end
end
