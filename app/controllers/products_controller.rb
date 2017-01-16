class ProductsController < ApplicationController
  require 'csv'

  def import
    ##Product import
    @products = Product.import_csv(params[:file])
    ## Failed Instances
    @failed_instances = @products.failed_instances
    @failed_count = @failed_instances.count
    @error_messages = @failed_instances.map{|c| "#{c.item_number} #{c.errors.full_messages.first}"}
    ##Get List of products imported
    @product_listing = Product.where("id in (?)",@products.ids)
    respond_to do |format|
     format.js
    end
  end

end
