module Management
  class ConferencesController < ManagementController
    before_action :assign_conference, only: [:edit, :update, :show, :destroy, :open_call_for_papers, :close_call_for_papers]
    before_action :assign_conferences, only: [:index, :destroy, :open_call_for_papers, :close_call_for_papers]

    def new
      @conference = Conference.new
      @conference.tracks.build(name: 'Track 1')
      @conference.halls.build(name: 'Hall 1')
    end

    def create
      @conference = Conference.new conference_params
      @conference.save
      render :new
    end

    def update
      @conference.update conference_params
      @conference.save
      render :edit
    end

    def edit
    end

    def index
    end

    def show
    end

    def destroy
      @conference.destroy

      render 'reload_table'
    end

    def open_call_for_papers
      @conference.call_for_papers_open = true
      @conference.save

      render 'reload_table'
    end

    def close_call_for_papers
      @conference.call_for_papers_open = false
      @conference.save

      render 'reload_table'
    end

    private

    def assign_conference
      @conference = Conference.find params[:id]
    end

    def assign_conferences
      @conferences = Conference.all.order(start_date: :desc)
    end

    def conference_params
      params.require(:conference).permit [:title,
                                          :email,
                                          :start_date,
                                          :end_date,
                                          :description,
                                          tracks_attributes: [:id,
                                                              :name,
                                                              :color,
                                                              :description,
                                                              :_destroy],
                                          halls_attributes: [:id,
                                                  :name,
                                                  :_destroy]
                                         ]
    end
  end
end
