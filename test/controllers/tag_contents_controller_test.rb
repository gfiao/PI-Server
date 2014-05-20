require 'test_helper'

class TagContentsControllerTest < ActionController::TestCase
  setup do
    @tag_content = tag_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tag_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tag_content" do
    assert_difference('TagContent.count') do
      post :create, tag_content: { content_id: @tag_content.content_id, tag_id: @tag_content.tag_id }
    end

    assert_redirected_to tag_content_path(assigns(:tag_content))
  end

  test "should show tag_content" do
    get :show, id: @tag_content
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tag_content
    assert_response :success
  end

  test "should update tag_content" do
    patch :update, id: @tag_content, tag_content: { content_id: @tag_content.content_id, tag_id: @tag_content.tag_id }
    assert_redirected_to tag_content_path(assigns(:tag_content))
  end

  test "should destroy tag_content" do
    assert_difference('TagContent.count', -1) do
      delete :destroy, id: @tag_content
    end

    assert_redirected_to tag_contents_path
  end
end
