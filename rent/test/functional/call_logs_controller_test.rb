require 'test_helper'

class CallLogsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => CallLog.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    CallLog.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    CallLog.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to call_log_url(assigns(:call_log))
  end

  def test_edit
    get :edit, :id => CallLog.first
    assert_template 'edit'
  end

  def test_update_invalid
    CallLog.any_instance.stubs(:valid?).returns(false)
    put :update, :id => CallLog.first
    assert_template 'edit'
  end

  def test_update_valid
    CallLog.any_instance.stubs(:valid?).returns(true)
    put :update, :id => CallLog.first
    assert_redirected_to call_log_url(assigns(:call_log))
  end

  def test_destroy
    call_log = CallLog.first
    delete :destroy, :id => call_log
    assert_redirected_to call_logs_url
    assert !CallLog.exists?(call_log.id)
  end
end
