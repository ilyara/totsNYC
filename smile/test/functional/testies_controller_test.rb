require 'test_helper'

class TestiesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Testie.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Testie.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Testie.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to testie_url(assigns(:testie))
  end

  def test_edit
    get :edit, :id => Testie.first
    assert_template 'edit'
  end

  def test_update_invalid
    Testie.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Testie.first
    assert_template 'edit'
  end

  def test_update_valid
    Testie.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Testie.first
    assert_redirected_to testie_url(assigns(:testie))
  end

  def test_destroy
    testie = Testie.first
    delete :destroy, :id => testie
    assert_redirected_to testies_url
    assert !Testie.exists?(testie.id)
  end
end
