require 'test_helper'

class ManagersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Manager.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Manager.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Manager.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to manager_url(assigns(:manager))
  end

  def test_edit
    get :edit, :id => Manager.first
    assert_template 'edit'
  end

  def test_update_invalid
    Manager.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Manager.first
    assert_template 'edit'
  end

  def test_update_valid
    Manager.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Manager.first
    assert_redirected_to manager_url(assigns(:manager))
  end

  def test_destroy
    manager = Manager.first
    delete :destroy, :id => manager
    assert_redirected_to managers_url
    assert !Manager.exists?(manager.id)
  end
end
