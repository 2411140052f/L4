require "test_helper"

class TopControllerTest < ActionDispatch::IntegrationTest
  test "root shows login form when not logged in" do
    get root_path

    assert_response :success
    assert_select "form[action=?]", top_login_path
    assert_select "input[name=uid]"
    assert_select "input[name=pass][type=password]"
  end

  test "valid credentials log in and show success" do
    User.create!(uid: "kindai", pass: "sanriko")

    post top_login_path, params: { uid: "kindai", pass: "sanriko" }

    assert_redirected_to top_main_path
    follow_redirect!
    assert_select "h1", "ログイン成功"
  end

  test "invalid credentials show an error below the button on the login form" do
    User.create!(uid: "kindai", pass: "different")

    post top_login_path, params: { uid: "kindai", pass: "sanriko" }

    assert_response :success
    assert_select "form input[type=submit] ~ p[role=alert]", "ログイン失敗"
    assert_select "input[name=uid]"
    assert_select "input[name=pass][type=password]"
  end

  test "logout clears the login session" do
    User.create!(uid: "kindai", pass: "sanriko")
    post top_login_path, params: { uid: "kindai", pass: "sanriko" }
    follow_redirect!

    assert_select "a[href=?]", top_logout_path, "ログアウト"

    get top_logout_path

    assert_redirected_to top_main_path
    follow_redirect!
    assert_select "form[action=?]", top_login_path
  end
end