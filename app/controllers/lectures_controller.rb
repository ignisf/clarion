class LecturesController < ApplicationController
  before_filter :authenticate_user!
  before_action :assign_lecture, only: [:show, :edit, :update]

  def index
    @lectures = Lecture.where user: current_user
  end

  def new
    @lecture = Lecture.new
  end

  def create
    @lecture = current_user.lectures.build lecture_params

    if @lecture.save
      after_save_redirection
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @lecture.update lecture_params
      after_save_redirection
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def assign_lecture
    @lecture = current_user.lectures.find params[:id]
  end

  def lecture_params
    params.require(:lecture).permit [:title, :subtitle, :length, :language, :abstract, :description, :notes, :track_id]
  end

  def after_save_redirection
    if current_user.speaker_profile.present?
      redirect_to @lecture
    else
      redirect_to edit_user_registration_path, alert: I18n.t(:please_fill_in_your_speaker_profile)
    end
  end

end
