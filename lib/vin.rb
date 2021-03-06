require "vin/version"
require "vin/model/address"
require "vin/model/subscriber"
require 'vin/model/error'
require 'vin/model/wine'
require 'vin/model/monthly_selection'
require 'vin/model/delivery'
require 'vin/model/shipment'
require 'vin/model/note'
require 'vin/model/admin'
require 'vin/validator/validator'
require 'vin/action/subscriber_action'
require 'vin/action/delivery_partner_action'
require 'vin/action/admin_action'
require 'vin/model/receipt'
require 'vin/helpers/helper_methods'

module Vin

  class WineClub

  attr_accessor :subscribers, :admins, :receipts, :monthly_selections, :wines
  attr_accessor :subscriber_action, :admin_action, :deliver_action
  attr_accessor :box_price, :delivery_charge
  attr_accessor :deleted_subscribers

  def initialize()
    @subscribers = Array.new
    @admins = Array.new
    @receipts = Array.new
    @subscriber_action = SubscriberAction.new
    @admin_action = AdminAction.new
    @deliver_action = DeliveryPartnerAction.new
    @monthly_selections = Array.new
    @wines = Array.new
    @box_price = 49.99
    @delivery_charge = 9.99
    @deleted_subscribers = []
  end

  end
end
