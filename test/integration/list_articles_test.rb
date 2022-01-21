require "test_helper"

class ListArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "testuser", email: "testuser@testuser.org",
      password: "Bl0gpa%%", admin: true)
    @article = Article.create(title: "Venus", description: "First Article", user_id: @user.id)
    @article2 = Article.create(title: "Aphrodite", description: "Second Article", user_id: @user.id)
  end

  test "should show articles listing" do
    get '/articles'
    assert_select "a[href=?]", article_path(@article), text: @article.title
    assert_select "a[href=?]", article_path(@article2), text: @article2.title
  end
end
