# typed: true
require "sorbet-runtime"
require "sinatra/base"
require "json"
require_relative "lib/fizzbuzz"
require_relative "lib/error"

class App < Sinatra::Base
  extend T::Sig

  set :default_content_type, :json
  set :show_exceptions, false
  set :fizzbuzz_limit, 50

  before "/:n" do |n|
    # `T.let` だけだと下記エラーになるので `T.must` もつけている
    #   The instance variable `@n` must be declared inside `initialize` or declared nilable (5005)
    @n = T.must(T.let(n.to_i, Integer))
    validation(@n)
  end

  get "/:n" do
    # beforeフィルタで既に型チェック済みだが、Sorbet的には必ずbeforeフィルタが通ることを認識できないので
    # ここでは `@n` が `T.untyped` になってしまう（一応 `T.untyped` のままでも動くが…）
    @n = T.must(T.let(@n, Integer))
    fizzbuzz = FizzBuzz.new(@n)
    result = fizzbuzz.run

    # そのままだと下記エラーが出るので `T.unsafe` で回避している
    #   Method `to_json` does not exist on `T::Hash[T.untyped, T.untyped]` component of `{message: T::Array[String]}` (fix available) (7003)
    T.unsafe({ message: result }).to_json
  end

  error ValidationError do |e|
    # `status` が認識されないので、手動で `sorbet/rbi/shims/sinatra.rbi` に追加してある
    status 500
    T.unsafe({ message: e.message }).to_json
  end

  error do |e|
    status 500
    T.unsafe({ message: "Unknown error" }).to_json
  end

  helpers do
    # 型定義をここに書いても認識されないので、`sorbet/rbi/shims/app.rbi` に書いてある
    # （認識されないのはDSLでのメソッド定義だからかもしれない）
    def validation(n)
      if n > settings.fizzbuzz_limit
        message =
          "Too large number is specified. Please specify a number up to #{settings.fizzbuzz_limit}."
        raise ValidationError, message
      end
    end
  end
end
