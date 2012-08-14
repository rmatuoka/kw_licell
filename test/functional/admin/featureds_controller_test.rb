require 'test_helper'

class Admin::FeaturedsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Featured.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Featured.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Featured.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin_featured_url(assigns(:featured))
  end

  def test_edit
    get :edit, :id => Featured.first
    assert_template 'edit'
  end

  def test_update_invalid
    Featured.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Featured.first
    assert_template 'edit'
  end

  def test_update_valid
    Featured.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Featured.first
    assert_redirected_to admin_featured_url(assigns(:featured))
  end

  def test_destroy
    featured = Featured.first
    delete :destroy, :id => featured
    assert_redirected_to admin_featureds_url
    assert !Featured.exists?(featured.id)
  end
end
