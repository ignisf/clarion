# TODO Needs to work with profiles, not with users
module Management
  class UsersController < ManagementController
    def index
      @profiles = current_conference.participant_profiles
    end

    def toggle_admin
      @user = find_user
      @user.toggle_admin!
      redirect_to :back
    end

    def show
      @user    = find_user
      @profile = @user.personal_profile(current_conference)
    end

    def edit
      @user = find_user
      @profile = @user.personal_profile(current_conference)
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
