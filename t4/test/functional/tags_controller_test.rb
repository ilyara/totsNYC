
require 'test_helper'
  setup do
class TagsControllerTest < ActionController::TestCase
  end
    @tag = tags(:one)
  test "should get index" do

    assert_response :success
    get :index
  end
    assert_not_nil assigns(:tags)
  test "should get new" do

    assert_response :success
    get :new

  end
    assert_difference('Tag.count') do
  test "should create tag" do
    end
      post :create, tag: @tag.attributes
    assert_redirected_to tag_path(assigns(:tag))


  end
    get :show, id: @tag.to_param
  test "should show tag" do
  end
    assert_response :success
  test "should get edit" do

    assert_response :success
    get :edit, id: @tag.to_param

  test "should update tag" do
    put :update, id: @tag.to_param, tag: @tag.attributes
  end
  end
    assert_redirected_to tag_path(assigns(:tag))
  test "should destroy tag" do

    assert_difference('Tag.count', -1) do
      delete :destroy, id: @tag.to_param
    end

    assert_redirected_to tags_path
  end
end
