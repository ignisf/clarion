module Public
  class VolunteersController < Public::ApplicationController
    def new
      @volunteer = current_conference.volunteers.build
    end

    def edit
      @volunteer = current_conference.volunteers.find_by! unique_id: params[:id]
    end

    def create
      @volunteer = current_conference.volunteers.build volunteer_params
      if @volunteer.save
        flash[:notice] = I18n.t('views.volunteers.successful_application')
        redirect_to edit_volunteer_path(@volunteer.unique_id)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @volunteer = current_conference.volunteers.find_by! unique_id: params[:id]
      if @volunteer.update volunteer_params
        flash[:notice] = I18n.t('views.volunteers.successful_application_edit')
        redirect_to edit_volunteer_path(@volunteer.unique_id)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def volunteer_params
      params.require(:volunteer).permit(
        :name, :picture, :email, :phone, :tshirt_size, :tshirt_cut,
        :food_preferences, :previous_experience, :notes, :language,
        volunteer_team_ids: []
      )
    end
  end
end
