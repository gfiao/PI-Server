require 'test_helper'

class ContentVideosControllerTest < ActionController::TestCase
  setup do
    @content_video = content_videos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:content_videos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content_video" do
    assert_difference('ContentVideo.count') do
      post :create, content_video: { content_id: @content_video.content_id, video_id: @content_video.video_id }
    end

    assert_redirected_to content_video_path(assigns(:content_video))
  end

  test "should show content_video" do
    get :show, id: @content_video
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @content_video
    assert_response :success
  end

  test "should update content_video" do
    patch :update, id: @content_video, content_video: { content_id: @content_video.content_id, video_id: @content_video.video_id }
    assert_redirected_to content_video_path(assigns(:content_video))
  end

  test "should destroy content_video" do
    assert_difference('ContentVideo.count', -1) do
      delete :destroy, id: @content_video
    end

    assert_redirected_to content_videos_path
  end
end
