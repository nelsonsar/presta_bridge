class ProductsController < ApplicationController
  cattr_accessor :catalog_class do
    Catalog
  end

  layout 'user'

  before_action :authorize

  def new
    @store_id = params[:store_id]
  end

  def show
    @product = catalog.find params[:id]
  end

  def index
    @store_name = store.name
    @products = catalog.all
  end

  def create
    product = Product.new(product_params)

    if product.valid?
      add_to_catalog product
    else
      flash[:error] = product.errors.full_messages
      redirect_to new_store_product_path(store)
    end
  end

  private

  def product_params
    params.require(:product)
          .permit(
            :name,
            :price
          )
  end

  def catalog
    catalog_class.new store
  end

  def add_to_catalog(product)
    if catalog.add(product)
      redirect_to store_products_path(store)
    else
      flash[:error] = ['Could not save the product']
      redirect_to new_store_product_path(store)
    end
  end

  def store
    current_user.store
  end
end
