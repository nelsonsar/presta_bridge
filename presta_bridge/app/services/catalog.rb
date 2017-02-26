class Catalog
  def initialize(store)
    @client = create_client(store)
  end

  def add(product)
    product.to_request.create
  rescue
    Rails.logger.error e.message.to_s
    false
  end

  def all
    if @client
      result = @client.connection.get :products
      result[:products][:product].map do |product_id|
        find product_id[:attr][:id]
      end
    else
      []
    end
  end

  def find(id)
    if @client
      product_hash = @client.connection.get :products, id.to_i
      Product.new(
        id: read_property(product_hash, :id),
        name: read_string_property(product_hash, :name),
        price: BigDecimal.new(read_property(product_hash, :price)),
        description: read_string_property(product_hash, :description)
      )
    else
      Product.new
    end
  end

  private

  def read_string_property(hash, name)
    hash[:product][name.to_sym][:language].first[:val].html_safe
  end

  def read_property(hash, name)
    hash[:product][name.to_sym]
  end

  def create_client(store)
    Prestashop::Client::Implementation.create store.api_key, store.url
  rescue
    nil
  end
end
