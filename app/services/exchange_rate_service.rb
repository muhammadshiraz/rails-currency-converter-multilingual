require 'net/http'
require 'json'

class ExchangeRateService
  BASE_URL = "https://api.exchangerate-api.com/v4/latest/"

  def initialize(from_currency, to_currency)
    @from_currency = from_currency
    @to_currency = to_currency
  end

  def fetch_rate
    url = URI("#{BASE_URL}#{@from_currency}")
    response = Net::HTTP.get_response(url)
    
    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      data["rates"][@to_currency].to_f
    else
      raise "Failed to fetch exchange rates"
    end
  rescue StandardError => e
    Rails.logger.error("Exchange rate error: #{e.message}")
    raise "Exchange rate service unavailable"
  end
end
