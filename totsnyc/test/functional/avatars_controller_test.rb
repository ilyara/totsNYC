require 'test_helper'

class AvatarsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Avatar.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Avatar.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Avatar.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to avatar_url(assigns(:avatar))
  end

  def test_edit
    get :edit, :id => Avatar.first
    assert_template 'edit'
  end

  def test_update_invalid
    Avatar.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Avatar.first
    assert_template 'edit'
  end

  def test_update_valid
    Avatar.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Avatar.first
    assert_redirected_to avatar_url(assigns(:avatar))
  end

  def test_destroy
    avatar = Avatar.first
    delete :destroy, :id => avatar
    assert_redirected_to avatars_url
    assert !Avatar.exists?(avatar.id)
  end
end
