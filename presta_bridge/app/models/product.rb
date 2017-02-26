class Product
  include ActiveModel::Model
  attr_accessor :name, :price, :id, :description

  validates_presence_of :name
  validates :price, presence: true, numericality: { greater_than: 0 }

  def to_request
    Prestashop::Mapper::Product.new(
      id_lang: 1,
      id_supplier: 1,
      reference: format('%s-%s', name.parameterize, rand(10000)),
      name: name,
      available_now: '',
      available_later: '',
      price: price
    )
  end
end
