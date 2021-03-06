class Wine
  @@ID = 1
  attr_reader :id, :ratings_count
  attr_accessor :label_name, :type, :variety, :grape, :region, :country, :maker, :year
  attr_accessor :notes

  def initialize(label_name="The Mission", type="Table", variety="Red", grape="Cabernet Sauvignon", region="Napa", country="USA", maker="Sterling", year="2011")
    @id = @@ID
    @@ID += 1
    @label_name = label_name
    @type = type
    @variety = variety
    @grape = grape
    @region = region
    @country = country
    @maker = maker
    @year = year
    @notes = Array.new
    @ratings_count = 0
    @rating = 0
  end

  def add_note(note)
    if note.class == Note
      @notes << note
    end
  end

  def delete_note(note_id)
    note = nil
    @notes.each do |n|
      if n.id == note_id
        note = n
        break
      end
    end
    if note
      @notes.delete(note)
    end
    note ? true : false
  end

  def to_h
    {
      'id' => @id,
      'label_name' => @label_name,
      'type' => @type,
      'variety' => @variety,
      'grape' => @grape,
      'region' => @region,
      'country' => @country,
      'maker' => @maker,
      'year' => @year,
      'ratings_count' => @ratings_count,
      'rating' => self.rating
    }
  end
def add_rating (rating)
  if rating <= 10 && rating >= 0
    @rating += rating.to_i
    @ratings_count += 1
    return true
  end
  false
end

def rating
  rating = 0.0
  if @ratings_count != 0
    rating = @rating.to_f / @ratings_count.to_f
  end
  rating.round 1
end

def is_match?(query)
  query = query.strip.downcase
  @label_name.downcase.include?(query) ||
  @type.downcase.include?(query) ||
  @variety.downcase.include?(query) ||
  @grape.downcase.include?(query) ||
  @region.downcase.include?(query) ||
  @country.downcase.include?(query) ||
  @maker.downcase.include?(query) ||
  @year.include?(query)
end

def get_note(nid)
  @notes.find { |e| e.id == nid }
end

def self.from_h(wine_hash)
  Wine.new wine_hash['label_name'], wine_hash['wine_type'], wine_hash['variety'], wine_hash['grape'], wine_hash['region'], wine_hash['country'], wine_hash['maker'], wine_hash['year']
end


end
