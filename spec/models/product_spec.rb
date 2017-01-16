require 'rails_helper'

RSpec.describe Product, type: :model do
  describe Product do
    it "is valid with the item number" do
      product = Product.new(
          item_number: 1,
      )
      expect(product).to be_valid
    end

    it "is invalid without item number" do
      product = Product.new(
          item_number: nil
      )
      product.valid?
      expect(product.errors[:item_number]).to include("can't be blank")
    end

  end
end
