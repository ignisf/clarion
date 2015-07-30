module Management
  class PersonalProfilesController < ManagementController
    def index
      @conference = find_conference

      # TODO @conference.participants
      @users = User.all
    end

    def toggle_admin
      @conference = find_conference
      @user       = find_profile.user

      @user.toggle_admin!
      redirect_to :back
    end

    def show
      @conference = find_conference
      @profile    = find_profile
      @user       = @profile.user

      if not @profile
        flash[:error] = "No profile, needs to be created"
        redirect_to action: :edit
      end
    end

    def new
      @conference = find_conference
      @profile = @conference.participant_profiles.
        build(user_id: params[:user_id])
    end

    def create
      @conference = find_conference
      @profile = PersonalProfile.new(profile_params)
      @profile.conference = @conference

      if @profile.save
        flash[:notice] = 'Profile was successfully created.'
        redirect_to action: :index
      else
        render action: :new
      end
    end

    def edit
      @conference = find_conference
      @profile    = find_profile
      @user       = @profile.user
    end

    def update
      @conference = find_conference
      @profile    = find_profile

      if @profile.update_attributes(profile_params)
        redirect_to [:management, @conference, @profile]
      else
        render action: 'edit'
      end
    end

    def destroy
      @profile = find_profile
      @profile.destroy

      redirect_to action: :index
    end

    private

    def find_profile
      PersonalProfile.find(params[:id])
    end

    def find_conference
      Conference.find(params[:conference_id])
    end

    def profile_params
      params.require(:personal_profile).permit(
        :picture,
        :first_name,
        :last_name,
        :mobile_phone,
        :biography,
        :organisation,
        :public_email,
        :github,
        :twitter,
        :user_id
      )
    end
  end
end
