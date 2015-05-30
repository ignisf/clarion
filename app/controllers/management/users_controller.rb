module Management
  class UsersController < ManagementController
    def index
      @users = User.includes(:speaker_profile)
    end

    def toggle_admin
      @user = find_user
      @user.toggle_admin!
    end

    def show
      @user    = find_user
      @profile = @user.speaker_profile
    end

    def edit
      @user = find_user
      @user.build_speaker_profile if @user.speaker_profile.blank?
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
        speaker_profile_attributes: [
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
