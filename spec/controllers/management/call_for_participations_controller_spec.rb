require 'rails_helper'

RSpec.describe Management::CallForParticipationsController, type: :controller do
  let(:user) { create :administrator }
  let(:conference) { create :conference }
  before { sign_in user }

  describe 'POST #create' do
    it 'opens the CFP of the specified conference' do
      expect do
        post 'create', conference_id: conference.id, format: :js
      end.to change { Conference.find(conference.id).call_for_participation.in_progress? }.from(false).to(true)
    end
  end

  describe 'DELETE #destroy' do
    it 'closes the CFP of the specified conference' do
      conference.call_for_participation.open!

      expect do
        delete 'destroy', conference_id: conference.id, format: :js
      end.to change { Conference.find(conference.id).call_for_participation.in_progress? }.from(true).to(false)
    end
  end
end
