# typed: strict

class App < Sinatra::Base
  class << self
    sig { params(n: Integer).void }
    def validation(n); end
  end
end
