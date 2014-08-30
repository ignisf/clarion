require 'rails_helper'

RSpec.describe LecturesController, type: :controller do
  let(:user) { create :user, confirmed_at: Time.now }

  before do
    sign_in user
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to be_success
    end

    it 'assigns a blank lecture to @lecture'
  end

  describe 'POST create' do
    it 'assigns the new lecture to @lecture'

    context 'when passed correct parameters' do
      it 'creates a new lecture'
      it 'redirects to the created lecture'
    end

    context 'when passed incorrect parameters' do
      it 'renders the edit template'
      it 'returns HTTP Unprocessable Entity status code'
    end
  end

  describe 'GET edit' do
    context 'when the lecture exists' do
      it 'returns http success'
      it 'assigns the lecture to @lecture'
    end

    context 'when the lecture does not exist' do
      it 'returns HTTP Not Found status code'
    end
  end

  describe 'PUT update' do
    context 'when the lecture does not exist' do
      it 'returns HTTP Not Found status code'
    end

    context 'when the lecture exists' do
      it 'assigns the lecture to @lecture'

      context 'when passed correct parameters' do
        it 'redirects to the updated lecture'
      end

      context 'when passed incorrect parameters' do
        it 'renders the edit template'
        it 'returns HTTP Unprocessable Entity status code'
      end
    end
  end

  describe 'GET show' do
    context 'when the lecture exists' do
      it 'returns HTTP Success status code'
      it 'assigns the lecture to @lecture'
    end

    context 'when the lecture does not exist' do
      it 'returns HTTP Not Found status code'
    end
  end
end
