require 'test_helper'

class FooterNewsControllerTest < ActionController::TestCase
  setup do
    @footer_news = footer_news(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:footer_news)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create footer_news" do
    assert_difference('FooterNews.count') do
      post :create, footer_news: { category: @footer_news.category, date: @footer_news.date, news: @footer_news.news }
    end

    assert_redirected_to footer_news_path(assigns(:footer_news))
  end

  test "should show footer_news" do
    get :show, id: @footer_news
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @footer_news
    assert_response :success
  end

  test "should update footer_news" do
    patch :update, id: @footer_news, footer_news: { category: @footer_news.category, date: @footer_news.date, news: @footer_news.news }
    assert_redirected_to footer_news_path(assigns(:footer_news))
  end

  test "should destroy footer_news" do
    assert_difference('FooterNews.count', -1) do
      delete :destroy, id: @footer_news
    end

    assert_redirected_to footer_news_index_path
  end
end
