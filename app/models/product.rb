# == Schema Information
#
# Table name: products
#
#  id            :integer          not null, primary key
#  item_number  :integer
#  status       :string
#  sales_type :string
#  cateogory    :string
#  description    :string
#

class Product < ApplicationRecord
  require 'csv'
  validates :item_number, presence: true

  ##Import Logic for product
  def self.import_csv(file)
    products = []
    CSV.foreach(file.path, headers: true) do |row|
      product_hash = row.to_hash # exclude the price field
      products << Product.new(product_hash)
    end
     product_imports = Product.import products, validate: true, on_duplicate_key_update: {conflict_target: [:item_number], index_name: :index_products_on_item_number, columns: [:status, :description, :sales_type]}
     return product_imports
  end
end
