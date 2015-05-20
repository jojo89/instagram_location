require 'spec_helper.rb'

describe InstagramFinder do
  let(:location) { double("Location", latitude: "42", longitude: "-74") }
  let(:instagram_api_response) { [OpenStruct.new(record_with_less_likes), OpenStruct.new(record_with_more_likes)] }
  let(:record_with_less_likes) {
  	instagram_attributes[:likes] = { "count" => 10 }
  	instagram_attributes
  }
  let(:record_with_more_likes) {
  	instagram_attributes[:likes] = { "count" => 15 }
  	instagram_attributes
  }
  let(:record_with_no_caption) {
  	instagram_attributes[:caption] = nil
  	instagram_attributes
  }
  let(:extracted_attributes_with_less_likes) {
    extracted_attributes[:likes] = 10
    extracted_attributes
  }
  let(:extracted_attributes_with_more_likes) {
    extracted_attributes[:likes] = 15
    extracted_attributes
  }
  let(:extracted_attributes_with_no_caption) {
    extracted_attributes[:description] = nil
    extracted_attributes
  }
  let(:instagram_attributes) { 
    {
      location: {
      	          "latitude" => 45, "longitude" => 45
      	        },
      user: OpenStruct.new(username: "josey", profile_picture: "pro.com"),
      images: OpenStruct.new(standard_resolution: OpenStruct.new(url: "nowhere.com")),
      caption: OpenStruct.new(text: "woah this pic is crazy"),
      likes:{
              "count" => 2
      	    },
      link: "instagram.com/sweet_pic",
    }
  }
  let(:extracted_attributes) { 
    { 
      latitude: 45, 
      longitude: 45, 
      username: "josey", 
      url: "nowhere.com", 
      description: "woah this pic is crazy", 
      link: "instagram.com/sweet_pic",
      likes: 2,
      profile_picture: "pro.com" 
    }
  }
  subject { described_class.new(location) }

  before do
    allow(subject).to receive(:instagram_location_call).and_return(instagram_api_response)
  end

  context "when the response contains all necessary attributes" do
    it "sorts the records in decsecnding order by likes" do
  	  expect(subject.fetch_records[0]).to eq(extracted_attributes_with_more_likes)
  	  expect(subject.fetch_records[1]).to eq(extracted_attributes_with_less_likes)
    end
  end

  context "when the response doesn't contain a caption" do
    let(:instagram_api_response) { [OpenStruct.new(record_with_no_caption)] }

    it "sorts the records in decsecnding order by likes" do
  	  expect(subject.fetch_records[0]).to eq(extracted_attributes_with_no_caption)
    end	
  end
end
