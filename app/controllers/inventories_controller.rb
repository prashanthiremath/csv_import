class InventoriesController < ApplicationController
  require 'csv'

  def import_on_hand
    begin
     uploaded_file = params[:file]
     @inventories = Inventory.import_on_hand(params[:file], params[:extract_date])
     if !uploaded_file && uploaded_file.original_filename=~/\.csv$/
       @message = "Please select a csv file."
     else
       @failed_instances = @inventories.failed_instances
       @failed_count = @failed_instances.count
       @error_messages = @failed_instances.map{|c| "#{c.item_number} #{c.errors.full_messages.first}"}
       @inventories_listing = Inventory.where("id in (?)",@inventories.ids)
       respond_to do |format|
        format.js
       end
     end
    rescue => e
      @message = "Some bad data in csv."
      respond_to do |format|
        format.js
      end
    end
  end

  def on_hand
  end

  def in_transit

  end

  def import_in_transit
    begin
      uploaded_file = params[:file]
      @inventories = Inventory.import_in_transit(params[:file], params[:extract_date])
      if !uploaded_file && uploaded_file.original_filename=~/\.csv$/
        @message = "Please select a csv file."
      else
        @failed_instances = @inventories.failed_instances
        @failed_count = @failed_instances.count
        @error_messages = @failed_instances.map{|c| "#{c.item_number} #{c.errors.full_messages.first}"}
        @inventories_listing = Inventory.where("id in (?)",@inventories.ids)
        respond_to do |format|
          format.js
        end
      end
    rescue => e
      @message = "Some bad data in csv."
      respond_to do |format|
        format.js
      end
    end
  end

end
