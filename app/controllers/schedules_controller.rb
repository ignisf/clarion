class SchedulesController < ApplicationController
  def show
    @schedule = Schedule.for_conference Conference.current
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"

    respond_to { |format| format.json { render json: @schedule.to_json } }
  end
end
