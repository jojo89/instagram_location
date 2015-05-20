require 'spec_helper.rb'
require 'io/console'
describe 'The HelloWorld App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "Contains the application headline" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Best Instagrams")
  end

  describe "GET '/instagram'" do
    before do
      allow_any_instance_of(InstagramFinder).to receive(:fetch_records).and_return(instagram_results)
    end

    context "when there are no instagram records" do
  	  let(:instagram_results) { [] }
      it "returns an empty array" do
          get '/instagram/Chicago'
          expect(last_response).to be_ok
          expect(eval(last_response.body)).to be_instance_of(Array)
          expect(eval(last_response.body)).to be_empty
      end
    end

    context "when there are instagram records" do
  	  let(:instagram_results) { [{}, {}, {}] }
      it "returns an empty array" do
          get '/instagram/Chicago'
          expect(last_response).to be_ok
          expect(eval(last_response.body)).to be_instance_of(Array)
          expect(eval(last_response.body).count).to eq(3)
      end
    end
  end
end