# == Schema Information
#
# Table name: Inventories
#
#  id            :integer          not null, primary key
#  item_number  :integer
#  status       :string
#  lot          :integer
#  org_number :integer
#  due_date    :date
#  extract_date :date
#  quantity     :integer
#  last_ship_date :date
#

class Inventory < ApplicationRecord
  attr_accessor :check_lot_exist
  validates :item_number, :org_number, :presence => true
  validates :lot, :presence => true,  :if => Proc.new{|f| !f.check_lot_exist.blank? }

  #Import logic for on hand inventory
  #Get the csv file and iterate each line of it
  #Check the uniq combination of item number, org number and lot
  #If already exist then update the rows
  def self.import_on_hand(file, date)
    inventories = []
    CSV.foreach(file.path, headers: true) do |row|
      inventories_hash = row.to_hash
      inventories_hash.merge!(check_lot_exist: true) #Apply validation of lot attribute only when check_lot_exist field not blank
      inventories_hash.merge!(extract_date: date)
      inventories << Inventory.new(inventories_hash)
    end
    inventories_imports = Inventory.import inventories, validate: true, on_duplicate_key_update: {conflict_target: [:item_number, :org_number, :lot], index_name: :index_inventories_on_item_number_and_org_number_and_lot, columns: [:quantity, :status, :last_ship_date, :extract_date]}
    return inventories_imports
  end


  #Import logic for In Transit inventory
  ##Check the unique combination of item numer and org number.
  def self.import_in_transit(file, date)
    inventories = []
    CSV.foreach(file.path, headers: true) do |row|
      inventories_hash = row.to_hash
      inventories_hash.merge!(extract_date: date)
      inventories << Inventory.new(inventories_hash)
    end
    inventories_imports = Inventory.import inventories, validate: true, on_duplicate_key_update: {conflict_target: [:item_number, :org_number], index_name: :index_inventories_on_item_number_and_org_number, columns: [:quantity,:status, :due_date, :extract_date]}
    return inventories_imports
  end
end