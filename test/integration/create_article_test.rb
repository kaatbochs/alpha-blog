require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest

  setup do
    @user = User.create(username: "testuser3", email: "testuser3@testuser.org", password: "Bl0gpa%%", admin: true)
    sign_in_as(@user)
  end

  test "get new article form and create article" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "Test Article Title", description: "Test Article Description" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Test Article Description", response.body
  end

  test "get new article form and reject bad title" do
    get "/articles/new"
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: " ", description: "Test Article Description" } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

  test "get new article form and reject bad description" do
    get "/articles/new"
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: "Test Article Title", description: " " } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
