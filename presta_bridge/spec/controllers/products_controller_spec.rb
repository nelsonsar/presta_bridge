require 'rails_helper'
require 'support/user_factory'
require 'support/store_factory'
require 'support/catalog_stub'

describe ProductsController do
  let(:user) { UserFactory.create }
  let(:store) { StoreFactory.create user.id }
  let(:product) do
    Product.new(
      id: 1,
      name: 'Test Product',
      price: '10.000',
      description: ''
    )
  end

  before do
    described_class.catalog_class = CatalogStub
  end

  describe 'GET #new' do
    it 'renders new template' do
      get :new, session: { user_id: user.id }, params: { store_id: store.id }

      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    it 'renders show template' do
      get :show, session: { user_id: user.id }, params: { id: 1 }

      expect(response).to render_template :show
    end
  end

  describe 'GET #index' do
    it 'renders index template with products' do
      get :index, session: { user_id: user.id }, params: { store_id: store.id }

      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'redirects user to products index page' do
        post :create, session: { user_id: user.id }, params: { product: { name: 'Foo', price: '10' }, store_id: store.id }

        expect(response).to redirect_to store_products_path(store)
      end
    end

    context 'with invalid parameters' do
      it 'redirects user back to products form' do
        post :create, session: { user_id: user.id }, params: { product: { name: '', price: '10' }, store_id: store.id }

        expect(response).to redirect_to new_store_product_path(store)
      end
    end
  end
end

