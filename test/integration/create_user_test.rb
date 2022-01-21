require "test_helper"

class CreateUserTest < ActionDispatch::IntegrationTest


  test "get new user form and create user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "testusername", email: "testuser@testsite.com",
        password: "Bl0gpa%%", admin: false } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "testusername", response.body
  end

  test "get new user form and reject bad user name" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "", email: "testuser@testsite.com",
        password: "Bl0gpa%%", admin: false } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

  test "get new user form and reject bad email" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "testusername", email: "",
        password: "Bl0gpa%%", admin: false } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

  test "get new user form and reject bad password" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "testusername", email: "testuser@testsite.com",
        password: "", admin: false } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
