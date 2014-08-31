class SpeakerProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_action :assign_speaker_profile

  def edit
  end

  def update
  end

  private

  def assign_speaker_profile
    @speaker_profile = SpeakerProfile.find_or_initialize_by(user: current_user)
  end
end
