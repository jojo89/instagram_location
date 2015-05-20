require 'json'
set :views, File.expand_path('../../views', __FILE__)

get '/' do
  erb :index
end

get '/instagram/:location' do
  location = Location.new(params["location"])
  if location.invalid_name?
    content_type :json
    []
  else
    @instagrams = InstagramFinder.new(location).fetch_records
    content_type :json
    @instagrams.to_json
  end
end
