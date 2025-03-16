require "test_helper"

class CurrencyControllerTest < ActionDispatch::IntegrationTest
  test "should get convert" do
    get currency_convert_url
    assert_response :success
  end
end
