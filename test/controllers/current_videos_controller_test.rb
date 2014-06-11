require 'test_helper'

class CurrentVideosControllerTest < ActionController::TestCase
  setup do
    @current_video = current_videos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:current_videos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create current_video" do
    assert_difference('CurrentVideo.count') do
      post :create, current_video: { index: @current_video.index }
    end

    assert_redirected_to current_video_path(assigns(:current_video))
  end

  test "should show current_video" do
    get :show, id: @current_video
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @current_video
    assert_response :success
  end

  test "should update current_video" do
    patch :update, id: @current_video, current_video: { index: @current_video.index }
    assert_redirected_to current_video_path(assigns(:current_video))
  end

  test "should destroy current_video" do
    assert_difference('CurrentVideo.count', -1) do
      delete :destroy, id: @current_video
    end

    assert_redirected_to current_videos_path
  end
end
