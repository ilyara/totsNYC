require 'test_helper'

class PhoneIdsControllerTest < ActionController::TestCase
  setup do
    @phone_id = phone_ids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phone_ids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phone_id" do
    assert_difference('PhoneId.count') do
      post :create, phone_id: @phone_id.attributes
    end

    assert_redirected_to phone_id_path(assigns(:phone_id))
  end

  test "should show phone_id" do
    get :show, id: @phone_id.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phone_id.to_param
    assert_response :success
  end

  test "should update phone_id" do
    put :update, id: @phone_id.to_param, phone_id: @phone_id.attributes
    assert_redirected_to phone_id_path(assigns(:phone_id))
  end

  test "should destroy phone_id" do
    assert_difference('PhoneId.count', -1) do
      delete :destroy, id: @phone_id.to_param
    end

    assert_redirected_to phone_ids_path
  end
end
