require 'test_helper'

class FreeClassroomsControllerTest < ActionController::TestCase
  setup do
    @free_classroom = free_classrooms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:free_classrooms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create free_classroom" do
    assert_difference('FreeClassroom.count') do
      post :create, free_classroom: { classroom_id: @free_classroom.classroom_id, time: @free_classroom.time, user_id: @free_classroom.user_id }
    end

    assert_redirected_to free_classroom_path(assigns(:free_classroom))
  end

  test "should show free_classroom" do
    get :show, id: @free_classroom
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @free_classroom
    assert_response :success
  end

  test "should update free_classroom" do
    patch :update, id: @free_classroom, free_classroom: { classroom_id: @free_classroom.classroom_id, time: @free_classroom.time, user_id: @free_classroom.user_id }
    assert_redirected_to free_classroom_path(assigns(:free_classroom))
  end

  test "should destroy free_classroom" do
    assert_difference('FreeClassroom.count', -1) do
      delete :destroy, id: @free_classroom
    end

    assert_redirected_to free_classrooms_path
  end
end
