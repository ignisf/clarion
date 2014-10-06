module Management
  class UsersController < ManagementController
    before_action :assign_user, only: [:show, :toggle_admin]

    def index
      @users = User.all
    end

    def toggle_admin
      @user.toggle_admin!
    end

    def show
    end

    private

    def assign_user
      @user = User.find params[:id]
    end
  end
end
