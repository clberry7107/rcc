require 'test_helper'

class NewreleasesControllerTest < ActionController::TestCase
  setup do
    @newrelease = newreleases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newreleases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newrelease" do
    assert_difference('Newrelease.count') do
      post :create, newrelease: {  }
    end

    assert_redirected_to newrelease_path(assigns(:newrelease))
  end

  test "should show newrelease" do
    get :show, id: @newrelease
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @newrelease
    assert_response :success
  end

  test "should update newrelease" do
    patch :update, id: @newrelease, newrelease: {  }
    assert_redirected_to newrelease_path(assigns(:newrelease))
  end

  test "should destroy newrelease" do
    assert_difference('Newrelease.count', -1) do
      delete :destroy, id: @newrelease
    end

    assert_redirected_to newreleases_path
  end
end
