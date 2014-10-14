module Management
  class ConferencesController < ManagementController
    before_action :assign_conference, only: [:edit]

    def new
      @conference = Conference.new
      3.times { @conference.tracks.build }
    end

    def create
      @conference = Conference.new conference_params
      @conference.save
      render :new
    end

    def edit
    end

    def index
      @conferences = Conference.all.order(start_date: :desc)
    end

    private

    def assign_conference
      @conference = Conference.find params[:id]
    end

    def conference_params
      params.require(:conference).permit [:title, :email, :start_date, :end_date, :description, tracks_attributes: [:id, :name, :color, :description, :_destroy]]
    end
  end
end
