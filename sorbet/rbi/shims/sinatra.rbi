# typed: strict

class Sinatra::Base
  class << self
    # `sorbet/rbi/gems/sinatra@2.2.2.rbi` の定義をそのまま持ってきた
    def status(value = T.unsafe(nil)); end
  end
end
