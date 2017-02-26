class CatalogStub
  def initialize(store);end

  def find(id)
    Product.new(
      id: 1,
      name: 'Test Product',
      price: '10.000',
      description: ''
    )
  end

  def all
    [
      Product.new(
        id: 1,
        name: 'Test Product',
        price: '10.000',
        description: ''
      )
    ]
  end

  def add(product)
    true
  end
end
