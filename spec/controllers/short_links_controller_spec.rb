require 'rails_helper'

RSpec.describe ShortLinksController, type: :controller do
  describe 'GET #show' do
    let!(:short_link) { create(:short_link) }
    let(:request) { get :show, params: { id: short_link.encoded_id } }

    it 'responds with a 301' do
      request
      expect(response).to have_http_status(:moved_permanently)
    end

    it 'redirects to the long_url' do
      expect(request).to redirect_to(short_link.long_link)
    end

    context 'with a missing short_link' do
      before(:each) do
        allow(ShortLink).to receive(:find_by_encoded_id).and_return(nil)
      end

      it 'returns a 404' do
        request
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    let(:params) { {} }
    let(:request) { post :create, params: params }

    context 'with valid params' do
      let(:long_link) { 'https://www.google.com' }
      let(:params) { { long_link: long_link} }

      it 'returns a 201' do
        request
        expect(response).to have_http_status(:created)
      end

      it 'creates a short_link' do
        expect { request }.to change(ShortLink, :count).by(1)
      end

      it 'returns payload' do
        request
        expect(JSON.parse(response.body)).
          to eq('long_link' => long_link, 'short_link' => "http://test.host/#{ShortLink.last.encoded_id}")
      end
    end

    context 'with invalid params' do
      context 'missing long_link' do
        let(:params) { { long_link: nil } }

        it 'returns a 422' do
          request
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns error' do
          request
          expect(JSON.parse(response.body)).to eq('long_link' => ["can't be blank", 'is invalid'])
        end
      end

      context 'invalid url' do
        let(:params) { { long_link: 'invalid' } }

        it 'returns a 422' do
          request
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns error' do
          request
          expect(JSON.parse(response.body)).to eq('long_link' => ['is invalid'])
        end
      end
    end
  end
end
