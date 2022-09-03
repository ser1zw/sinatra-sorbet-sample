# typed: strict
require 'sorbet-runtime'

class FizzBuzz
  extend T::Sig

  sig { params(n: Integer).void }
  def initialize(n)
    @n = n
  end

  sig { returns(T::Array[T.any(String, Integer)]) }
  def run
    ret = 1.upto(@n).map do |i|
      if i % 15 == 0
        'FizzBuzz'
      elsif i % 3 == 0
        'Fizz'
      elsif i % 5 == 0
        'Buzz'
      else
        i
      end
    end

    ret
  end
end
