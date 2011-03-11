require 'test_helper'

class KukusControllerTest < ActionController::TestCase
  setup do
    @kuku = kukus(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kukus)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kuku" do
    assert_difference('Kuku.count') do
      post :create, :kuku => @kuku.attributes
    end

    assert_redirected_to kuku_path(assigns(:kuku))
  end

  test "should show kuku" do
    get :show, :id => @kuku.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @kuku.to_param
    assert_response :success
  end

  test "should update kuku" do
    put :update, :id => @kuku.to_param, :kuku => @kuku.attributes
    assert_redirected_to kuku_path(assigns(:kuku))
  end

  test "should destroy kuku" do
    assert_difference('Kuku.count', -1) do
      delete :destroy, :id => @kuku.to_param
    end

    assert_redirected_to kukus_path
  end
end
