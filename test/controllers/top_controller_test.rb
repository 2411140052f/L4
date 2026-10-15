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
    post top_login_path, params: { uid: "kindai", pass: "sanriko" }

    assert_redirected_to top_main_path
    follow_redirect!
    assert_select "h1", "ログイン成功"
  end

  test "invalid credentials show a generic error" do
    post top_login_path, params: { uid: "wrong", pass: "wrong" }

    assert_response :success
    assert_select "h1", "IDまたはパスワードが違います"
  end
end