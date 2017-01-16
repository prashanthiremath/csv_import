require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe Inventory do
    it "is valid with the item number" do
      inventory = Inventory.new(
          item_number: 1,
          org_number: 1
      )
      expect(inventory).to be_valid
    end

    it "is invalid without item number" do
      inventory = Inventory.new(
          item_number: nil
      )
      inventory.valid?
      expect(inventory.errors[:item_number]).to include("can't be blank")
    end

  end
end
