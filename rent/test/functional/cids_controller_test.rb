require 'test_helper'

class CidsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Cid.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Cid.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Cid.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to cid_url(assigns(:cid))
  end

  def test_edit
    get :edit, :id => Cid.first
    assert_template 'edit'
  end

  def test_update_invalid
    Cid.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Cid.first
    assert_template 'edit'
  end

  def test_update_valid
    Cid.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Cid.first
    assert_redirected_to cid_url(assigns(:cid))
  end

  def test_destroy
    cid = Cid.first
    delete :destroy, :id => cid
    assert_redirected_to cids_url
    assert !Cid.exists?(cid.id)
  end
end
