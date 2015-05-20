class InstagramLocationFetcher
  def initialize(location, limit = 50)
    @location = location
    @limit = limit
  end

  def fetch_records
    instagram_location_call.map do |instagram_record|
      extract_attributes(instagram_record)
    end.compact.sort_by{ |instagram_record| instagram_record[:likes] }.reverse
  end

  private
  attr_reader :location, :limit

  def instagram_location_call
    Instagram.media_search(location.latitude, location.longitude, {radius: 4500, count: limit})
  end

  def extract_attributes(instagram_record)
    caption = instagram_record.caption ? instagram_record.caption.text : nil
      { 
        latitude: instagram_record["location"]["latitude"], 
        longitude: instagram_record["location"]["longitude"], 
        username: instagram_record.user.username, 
        url: instagram_record.images.standard_resolution.url, 
        description: caption, 
        likes: instagram_record.likes["count"], 
        link: instagram_record.link,
        profile_picture: instagram_record.user.profile_picture 
      }
  end
end
