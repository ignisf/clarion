class LecturesController < ApplicationController
  def new
    @lecture = Lecture.new
  end

  def create
    head :created
  end

  def edit
  end

  def update
  end

  def show
  end
end
