class SessionsController < Devise::SessionsController
  def after_sign_in_path_for(user)
    if user.speaker_profile.present?
      stored_location_for(user) || signed_in_root_path(user)
    else
      edit_user_registration_path
    end
  end
end
