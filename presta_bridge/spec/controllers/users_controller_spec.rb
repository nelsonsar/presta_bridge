require 'rails_helper'

describe UsersController do
  describe 'GET #new' do
    it 'renders new template' do
      get :new

      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:valid_user_request) do
      {
        user: {
          name: 'Foo',
          email: 'foo@foo.com',
          password: '12345',
          password_confirmation: '12345'
        }
      }
    end

    let(:invalid_user_request) do
      {
        user: {
          name: 'Foo',
          email: 'foo@foo.com',
          password: '',
          password_confirmation: ''
        }
      }
    end

    context 'with valid params' do
      it 'sets user id in session' do
        expect { post :create, params: valid_user_request }.to change(User, :count)

        expect(session[:user_id]).to_not be_nil
      end
    end

    context 'with invalid parameters' do
      it 'redirects to new' do
        post :create, params: invalid_user_request

        expect(response).to redirect_to new_user_url
      end
    end
  end
end
