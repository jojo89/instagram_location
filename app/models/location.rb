class Location
  def initialize(name)
    @coordinates = Geocoder.coordinates(name)
  end

  def invalid_name?
    !coordinates
  end
  
  def latitude
    coordinates[0]
  end

  def longitude
    coordinates[1]
  end

  private

  attr_reader :coordinates
end
