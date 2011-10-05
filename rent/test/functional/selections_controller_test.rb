require 'test_helper'

class SelectionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Selection.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Selection.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Selection.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to selection_url(assigns(:selection))
  end

  def test_edit
    get :edit, :id => Selection.first
    assert_template 'edit'
  end

  def test_update_invalid
    Selection.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Selection.first
    assert_template 'edit'
  end

  def test_update_valid
    Selection.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Selection.first
    assert_redirected_to selection_url(assigns(:selection))
  end

  def test_destroy
    selection = Selection.first
    delete :destroy, :id => selection
    assert_redirected_to selections_url
    assert !Selection.exists?(selection.id)
  end
end
