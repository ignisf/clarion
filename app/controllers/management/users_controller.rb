module Management
  class UsersController < ManagementController
    def index
      @users = User.all
    end

    def toggle_admin
      @user = find_user
      @user.toggle_admin!
    end

    def show
      @user    = find_user
      @profile = @user.speaker_profile
    end

    private

    def find_user
      User.find(params[:id])
    end
  end
end
