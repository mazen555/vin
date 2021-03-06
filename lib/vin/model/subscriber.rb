class Subscriber
  @@ID = 1
  attr_reader :id
  attr_accessor :name, :email, :address, :phone, :facebook, :twitter
  attr_accessor :delivery
  attr_accessor :shipments
  attr_accessor :create_date

  def initialize (name, email, address, phone, facebook="", twitter="")
    @id = @@ID
    @@ID += 1
    @name = name
    @email = email
    @address = address
    @phone = Phonelib.parse(phone).sanitized
    @facebook = facebook
    @twitter = twitter
    @delivery = Delivery.new
    @shipments = Array.new
    @create_date = Time.now
  end

  def add_shipment(shipment)
    if(shipment.class == Shipment)
      @shipments << shipment
    end
  end

  def to_h
    {
      'name' => @name,
      'email' => @email,
      'address' => @address.to_h,
      'phone' => @phone,
      'facebook' => @facebook || "",
      'twitter' => @twitter || ""
    }
  end

  def is_match?(query)
    query = query.strip.downcase
    @name.downcase.include?(query)||
    @email.downcase.include?(query)||
    @address.is_match?(query)||
    @phone.downcase.include?(query)||
    @facebook.downcase.include?(query)||
    @twitter.downcase.include?(query)
  end

  def get_shipment(sid)
    @shipments.find {|e| e.id == sid}
  end

  def get_shipment_note(sid, nid)
    ship = self.get_shipment(sid)
    if ship
      note = ship.get_note(nid)
      return note
    end
  end

  def get_wines
    wines = []
    ids = Set.new
    @shipments.each do |ship|
      ship.wines.each do |wine|
        if !ids.include? wine.id
          wines << wine
          ids.add wine.id
        end
      end
    end
    wines
  end

  def get_wine(wid)
    wines = self.get_wines
    wines.find { |wine| wine.id == wid }
  end

end
