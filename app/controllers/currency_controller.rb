class CurrencyController < ApplicationController
  before_action :set_locale
  before_action :set_language_options, only: [:convert]

  CURRENCIES = %w[USD EUR GBP JPY AUD CAD CHF CNY INR].freeze

  def convert
    return unless params[:commit]

    begin
      rate = ExchangeRateService.new(params[:from_currency], params[:to_currency]).fetch_rate
      @result = params[:amount].to_f * rate
    rescue => e
      flash[:error] = I18n.t('conversion_error')
    end
  end

  def set_locale
    if params[:locale].present? && params[:locale] != session[:locale]
      session[:locale] = params[:locale]
      I18n.locale = session[:locale]
      redirect_back(fallback_location: root_path) and return
    else
      I18n.locale = session[:locale] || I18n.default_locale
    end
  end  

  private

  def set_language_options
    @language_options = [
      ['English', 'en'],
      ['Français', 'fr'],
      ['Español', 'es'],
      ['Deutsch', 'de'],
      ['العربية', 'ar']
    ]
  end
end
