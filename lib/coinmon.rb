require 'net/http'
require 'json'
require 'coinmon/tablifier'

class Coinmon
  class << self
    def run(portfolio, currency)
      conversion_rate = load_json(
        "https://api.fixer.io/latest?base=#{currency}&symbols=USD"
      ).dig('rates', 'USD')

      rates = load_rates portfolio.keys
      portfolio.each do |symbol, data|
        amount = data[:amount]
        investment = data[:investment]
        rate_gbp = rates[symbol] / conversion_rate
        price = amount * rate_gbp
        data.merge!(
          paid_per_unit: investment / amount,
          price_per_unit: rate_gbp,
          price: price,
          earnings: price - investment
        )
      end
    end

    private

    API_URL ||= 'http://coincap.io'.freeze

    def load_json(url)
      JSON.parse Net::HTTP.get URI url
    end

    def load_coin_price(symbol)
      load_json("#{API_URL}/page/#{symbol.upcase}").fetch('price_usd', 0)
    end

    def load_rates(symbols)
      symbols.map  { |symbol| spawn_worker symbol }
             .map  { |thread| thread.join[:r] }
             .each_with_object({}) do |data, ret|
        ret[data[:symbol]] = data[:price_usd]
      end
    end

    def spawn_worker(symbol)
      Thread.new do
        Thread.current[:r] = { symbol: symbol, price_usd: load_coin_price(symbol) }
      end
    end
  end
end
