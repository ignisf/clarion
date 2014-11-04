class HomeController < ApplicationController
  def index
    @current_conference = Conference.first
  end
end
