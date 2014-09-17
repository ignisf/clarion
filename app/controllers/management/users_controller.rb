module Management
  class UsersController < ManagementController
    before_action :assign_user, only: [:toggle_admin]

    def index
      @users = User.all
    end

    def toggle_admin
      @user.admin = !@user.admin
      @user.save
    end

    private

    def assign_user
      @user = User.find params[:id]
    end
  end
end
