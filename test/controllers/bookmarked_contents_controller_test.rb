require 'test_helper'

class BookmarkedContentsControllerTest < ActionController::TestCase
  setup do
    @bookmarked_content = bookmarked_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookmarked_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookmarked_content" do
    assert_difference('BookmarkedContent.count') do
      post :create, bookmarked_content: { content_id: @bookmarked_content.content_id, user_id: @bookmarked_content.user_id }
    end

    assert_redirected_to bookmarked_content_path(assigns(:bookmarked_content))
  end

  test "should show bookmarked_content" do
    get :show, id: @bookmarked_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bookmarked_content
    assert_response :success
  end

  test "should update bookmarked_content" do
    patch :update, id: @bookmarked_content, bookmarked_content: { content_id: @bookmarked_content.content_id, user_id: @bookmarked_content.user_id }
    assert_redirected_to bookmarked_content_path(assigns(:bookmarked_content))
  end

  test "should destroy bookmarked_content" do
    assert_difference('BookmarkedContent.count', -1) do
      delete :destroy, id: @bookmarked_content
    end

    assert_redirected_to bookmarked_contents_path
  end
end
