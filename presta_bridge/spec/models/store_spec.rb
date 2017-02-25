require 'rails_helper'

describe Store do
  describe 'Validations' do
    context 'invalid api key' do
      it 'is not valid if api key size is not 32' do
        store = Store.new(
          name: 'Foo',
          url: 'http://foostore.com',
          api_key: '12345678'
        )

        expect(store).to_not be_valid
      end
    end

    context 'invalid URL' do
      it 'is not valid if URL is not an HTTP/HTTPS URL' do
        store = Store.new(
          name: 'Foo',
          url: 'localhost',
          api_key: '12345678'
        )

        expect(store).to_not be_valid
      end
    end
  end
end
