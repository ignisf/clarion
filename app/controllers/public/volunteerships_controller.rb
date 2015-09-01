module Public
  class VolunteershipsController < Public::ApplicationController
    before_filter :authenticate_user!, only: [:create, :destroy]

    def index
      @volunteer_teams = current_conference.volunteer_teams
    end

    def create
      @volunteer_team = current_conference.volunteer_teams.find params[:volunteer_team_id]
      @volunteership = @volunteer_team.volunteerships.build volunteer: current_user
      @volunteership.build_proposition proposer: current_user, status: :undecided

      if @volunteership.save
        flash[:notice] = I18n.t('views.volunteerships.you_successfully_applied_for', team: @volunteership.volunteer_team.name)
      else
        flash[:error] = I18n.t('views.volunteerships.an error_occurred_while_applying')
      end

      after_save_redirect
    end

    def destroy
      @volunteership = current_user.volunteerships.find params[:id]

      if @volunteership.destroy
        flash[:notice] = I18n.t('views.volunteerships.you_successfully_retracted_your_application_for', team: @volunteership.volunteer_team.name)
      end

      redirect_to volunteerships_path
    end

    private

    def volunteership_params
      params.require(:volunteership).permit(
        :title, :subtitle, :track_id, :length, :language,
        :abstract, :description, :notes, :agreement,
        :volunteership_type_id
      )
    end

    def after_save_redirect
      if current_user.personal_profile(current_conference).present?
        redirect_to volunteerships_path
      else
        redirect_to edit_personal_profile_path, alert: I18n.t(:please_fill_in_your_speaker_profile)
      end
    end
  end
end
