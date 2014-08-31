require 'rails_helper'

RSpec.describe WorkshopsController, type: :controller do
  let(:user) { create :user, confirmed_at: Time.now }

  before do
    sign_in user
  end

  describe 'GET index' do
    it 'returns HTTP Success status code'
    it 'assigns the workshops of the current user to @workshops'
  end

  describe 'GET new' do
    it 'returns HTTP Success status code' do
      get :new
      expect(response).to be_success
    end

    it 'assigns a blank workshop to @workshop'
  end

  describe 'POST create' do
    it 'assigns the new workshop to @workshop'

    context 'when passed correct parameters' do
      it 'creates a new workshop'
      it 'redirects to the created workshop'
    end

    context 'when passed incorrect parameters' do
      it 'renders the edit template'
      it 'returns HTTP Unprocessable Entity status code'
    end
  end

  describe 'GET edit' do
    context 'when the workshop exists' do
      it 'returns http success'
      it 'assigns the workshop to @workshop'
    end

    context 'when the workshop does not exist' do
      it 'returns HTTP Not Found status code'
    end
  end

  describe 'PUT update' do
    context 'when the workshop does not exist' do
      it 'returns HTTP Not Found status code'
    end

    context 'when the workshop exists' do
      it 'assigns the workshop to @workshop'

      context 'when passed correct parameters' do
        it 'redirects to the updated workshop'
      end

      context 'when passed incorrect parameters' do
        it 'renders the edit template'
        it 'returns HTTP Unprocessable Entity status code'
      end
    end
  end

  describe 'GET show' do
    context 'when the workshop exists' do
      it 'returns HTTP Success status code'
      it 'assigns the workshop to @workshop'
    end

    context 'when the workshop does not exist' do
      it 'returns HTTP Not Found status code'
    end
  end
end
