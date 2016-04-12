require 'test_helper'

class NewseriesControllerTest < ActionController::TestCase
  setup do
    @newseries = newseries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newseries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newseries" do
    assert_difference('Newseries.count') do
      post :create, newseries: {  }
    end

    assert_redirected_to newseries_path(assigns(:newseries))
  end

  test "should show newseries" do
    get :show, id: @newseries
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @newseries
    assert_response :success
  end

  test "should update newseries" do
    patch :update, id: @newseries, newseries: {  }
    assert_redirected_to newseries_path(assigns(:newseries))
  end

  test "should destroy newseries" do
    assert_difference('Newseries.count', -1) do
      delete :destroy, id: @newseries
    end

    assert_redirected_to newseries_index_path
  end
end
