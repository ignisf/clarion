class HomeController < ApplicationController
  def index
    @current_conference = Conference.current || Conference.new
  end
end
