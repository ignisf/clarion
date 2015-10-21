module Public
  class VolunteerTeamsController < Public::ApplicationController
    def index
      @volunteer_teams = current_conference.volunteer_teams
    end
  end
end
