module Public
  class PersonalProfilesController < Public::ApplicationController
    before_action :authenticate_user!

    def create
      @profile = current_user.build_personal_profile(current_conference, profile_params)

      if @profile.save
        flash[:notice] = t("views.personal_profiles.successfully_created")
        redirect_to root_path
      else
        render action: :new
      end
    end

    def edit
      @profile = current_user.find_or_build_personal_profile(current_conference)
    end

    def update
      @profile = current_user.personal_profile(current_conference)

      if @profile.update_attributes(profile_params)
        flash[:notice] = t("views.personal_profiles.successfully_updated")
        redirect_to root_path
      else
        render action: "edit"
      end
    end

    private

    def profile_params
      params.require(:personal_profile).permit(
        :picture, :picture_cache, :first_name, :last_name, :public_email,
        :organisation, :github, :twitter, :mobile_phone, :biography
      )
    end
  end
end
