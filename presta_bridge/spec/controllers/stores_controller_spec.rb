require 'rails_helper'

describe StoresController do
  let(:user) { UserFactory.create }

  describe 'GET #new' do
    it 'renders new template' do
      get :new, session: { user_id: user.id }, params: { user_id: user.id }

      expect(response).to render_template :new
    end
  end

  describe 'GET #create' do
    let(:valid_parameters) do
      {
        store: {
          name: 'Foo',
          url: 'http://foostore.com',
          api_key: '1' * 32
        },
        user_id: user.id
      }
    end

    let(:invalid_parameters) do
      {
        store: {
          name: '',
          url: 'http://foostore.com',
          api_key: '1' * 32
        },
        user_id: user.id
      }
    end

    context 'with valid parameters' do
      it 'redirects user back to settings page' do
        expect do
          post :create, session: { user_id: user.id }, params: valid_parameters
        end.to change(Store, :count).by(1)

        expect(response).to redirect_to settings_path
      end
    end

    context 'with invalid parameters' do
      it 'redirects user back to new store form' do
        post :create, session: { user_id: user.id }, params: invalid_parameters

        expect(response).to redirect_to new_user_store_path(user)
        expect(flash[:error]).to_not be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys user store' do
      store = Store.create(
        name: 'Foo',
        url: 'http://foosstore.com',
        user_id: user.id,
        api_key: '9' * 32
      )

      expect do
        delete :destroy, session: { user_id: user.id }, params: { id: store.id }
      end.to change(Store, :count).by(-1)

      expect(response).to redirect_to settings_path
    end
  end
end
