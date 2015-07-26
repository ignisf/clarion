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
    end

    def edit
      @conference = find_conference
      @user       = find_user
      @profile    = @user.personal_profile(@conference)
    end

    def update
      @user = find_user

      if @user.update_attributes(user_params)
        redirect_to [:management, @user]
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
        personal_profile_attributes: [
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
