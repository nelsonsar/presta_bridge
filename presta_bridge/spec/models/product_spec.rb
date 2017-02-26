require 'rails_helper'

describe Product do
  describe '#to_request' do
    it 'returns an instance of Prestashop Mapper' do
      product = Product.new(name: 'Foo', price: 1000)

      expect(product.to_request).to be_an_instance_of Prestashop::Mapper::Product
    end
  end
end
