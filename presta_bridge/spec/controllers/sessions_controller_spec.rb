require 'rails_helper'
require 'support/user_factory'

describe SessionsController do
  describe 'GET #new' do
    context 'anonymous user' do
      it 'renders new template' do
        get :new

        expect(response).to render_template :new
      end
    end

    context 'already authenticated user' do
      let(:user) { UserFactory.create }

      it 'it redirects user to settings page' do
        get :new, session: { user_id: user.id }

        expect(response).to redirect_to settings_path
      end
    end
  end

  describe 'POST #create' do
    context 'existing user' do
      before { UserFactory.create }
      it 'redirects user to settings page' do
        post :create, params: { email: 'foo@foo.com', password: '12345' }

        expect(session[:user_id]).to_not be_nil
        expect(response).to redirect_to settings_path
      end
    end

    context 'invalid credentials' do
      it 'redirects to back to login form' do
        post :create, params: { email: 'foo@foo.com', password: '123' }

        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to login_path' do
      delete :destroy

      expect(session[:user_id]).to be nil
      expect(response).to redirect_to login_path
    end
  end
end
