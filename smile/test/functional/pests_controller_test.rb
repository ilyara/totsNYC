require 'test_helper'

class PestsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Pest.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Pest.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Pest.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to pest_url(assigns(:pest))
  end

  def test_edit
    get :edit, :id => Pest.first
    assert_template 'edit'
  end

  def test_update_invalid
    Pest.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Pest.first
    assert_template 'edit'
  end

  def test_update_valid
    Pest.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Pest.first
    assert_redirected_to pest_url(assigns(:pest))
  end

  def test_destroy
    pest = Pest.first
    delete :destroy, :id => pest
    assert_redirected_to pests_url
    assert !Pest.exists?(pest.id)
  end
end
