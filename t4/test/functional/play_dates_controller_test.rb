require 'test_helper'

class PlayDatesControllerTest < ActionController::TestCase
  setup do
    @play_date = play_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:play_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create play_date" do
    assert_difference('PlayDate.count') do
      post :create, play_date: @play_date.attributes
    end

    assert_redirected_to play_date_path(assigns(:play_date))
  end

  test "should show play_date" do
    get :show, id: @play_date.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @play_date.to_param
    assert_response :success
  end

  test "should update play_date" do
    put :update, id: @play_date.to_param, play_date: @play_date.attributes
    assert_redirected_to play_date_path(assigns(:play_date))
  end

  test "should destroy play_date" do
    assert_difference('PlayDate.count', -1) do
      delete :destroy, id: @play_date.to_param
    end

    assert_redirected_to play_dates_path
  end
end
