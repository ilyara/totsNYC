require 'test_helper'

class GadfliesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Gadfly.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Gadfly.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Gadfly.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to gadfly_url(assigns(:gadfly))
  end

  def test_edit
    get :edit, :id => Gadfly.first
    assert_template 'edit'
  end

  def test_update_invalid
    Gadfly.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Gadfly.first
    assert_template 'edit'
  end

  def test_update_valid
    Gadfly.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Gadfly.first
    assert_redirected_to gadfly_url(assigns(:gadfly))
  end

  def test_destroy
    gadfly = Gadfly.first
    delete :destroy, :id => gadfly
    assert_redirected_to gadflies_url
    assert !Gadfly.exists?(gadfly.id)
  end
end
