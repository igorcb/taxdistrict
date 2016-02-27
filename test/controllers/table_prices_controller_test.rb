require 'test_helper'

class TablePricesControllerTest < ActionController::TestCase
  setup do
    @table_price = table_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:table_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create table_price" do
    assert_difference('TablePrice.count') do
      post :create, table_price: { district_origin_id: @table_price.district_origin_id, district_target_id: @table_price.district_target_id, price: @table_price.price }
    end

    assert_redirected_to table_price_path(assigns(:table_price))
  end

  test "should show table_price" do
    get :show, id: @table_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @table_price
    assert_response :success
  end

  test "should update table_price" do
    patch :update, id: @table_price, table_price: { district_origin_id: @table_price.district_origin_id, district_target_id: @table_price.district_target_id, price: @table_price.price }
    assert_redirected_to table_price_path(assigns(:table_price))
  end

  test "should destroy table_price" do
    assert_difference('TablePrice.count', -1) do
      delete :destroy, id: @table_price
    end

    assert_redirected_to table_prices_path
  end
end
