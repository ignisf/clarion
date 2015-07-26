# TODO Needs to work with profiles, not with users
module Management
  class UsersController < ManagementController
    def index
      @conference = find_conference
      @profiles = @conference.participant_profiles
    end

    def toggle_admin
      @conference = find_conference
      @user       = find_user

      @user.toggle_admin!
      redirect_to :back
    end

    def show
      @conference = find_conference
      @user       = find_user
      @profile    = @user.personal_profile(@conference)

      if not @profile
        flash[:error] = "No profile, needs to be created"
        redirect_to action: :edit
      end
    end

    def edit
      @conference = find_conference
      @user       = find_user
      @profile    = @user.personal_profile(@conference)

      # TODO (2015-07-26) Totally not working, can't create new profile properly
      if not @profile
        @profile = @user.clone_recent_profile(@conference)
      end
    end

    def update
      @conference = find_conference
      @user       = find_user

      if @user.update_attributes(user_params)
        redirect_to [:management, @conference, @user]
      else
        render action: 'edit'
      end
    end

    def destroy
      @user = find_user
      @user.destroy

      redirect_to action: :index
    end

    private

    def find_user
      User.find(params[:id])
    end

    def find_conference
      Conference.find(params[:conference_id])
    end

    def user_params
      params.require(:user).permit(
        :email,
        personal_profiles_attributes: [
          :picture,
          :first_name,
          :last_name,
          :mobile_phone,
          :biography,
          :organisation,
          :public_email,
          :github,
          :twitter,
        ]
      )
    end
  end
end
