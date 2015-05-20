require 'spec_helper.rb'
describe 'Index Controller' do

  it "Contains the application headline" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Best Instagrams")
  end

  describe "GET '/instagram'" do
  	let(:response_body) { eval(last_response.body) }
    
    before do
      allow_any_instance_of(InstagramLocationFetcher).to receive(:fetch_records).and_return(instagram_results)
    end

    context "when there are no instagram records" do
  	  let(:instagram_results) { [] }
      it "returns an empty array" do
          get '/instagram/Chicago'
          expect(last_response).to be_ok
          expect(response_body).to be_instance_of(Array)
          expect(response_body).to be_empty
      end
    end

    context "when there are instagram records" do
  	  let(:instagram_results) { [{}, {}, {}] }
      it "returns an empty array" do
          get '/instagram/Chicago'
          expect(last_response).to be_ok
          expect(response_body).to be_instance_of(Array)
          expect(response_body.count).to eq(3)
      end
    end
  end
end