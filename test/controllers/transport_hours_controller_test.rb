require 'test_helper'

class TransportHoursControllerTest < ActionController::TestCase
  setup do
    @transport_hour = transport_hours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transport_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transport_hour" do
    assert_difference('TransportHour.count') do
      post :create, transport_hour: { hour_id: @transport_hour.hour_id, transport_id: @transport_hour.transport_id }
    end

    assert_redirected_to transport_hour_path(assigns(:transport_hour))
  end

  test "should show transport_hour" do
    get :show, id: @transport_hour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transport_hour
    assert_response :success
  end

  test "should update transport_hour" do
    patch :update, id: @transport_hour, transport_hour: { hour_id: @transport_hour.hour_id, transport_id: @transport_hour.transport_id }
    assert_redirected_to transport_hour_path(assigns(:transport_hour))
  end

  test "should destroy transport_hour" do
    assert_difference('TransportHour.count', -1) do
      delete :destroy, id: @transport_hour
    end

    assert_redirected_to transport_hours_path
  end
end
