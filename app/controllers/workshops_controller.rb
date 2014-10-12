class WorkshopsController < ApplicationController
  before_filter :authenticate_user!
  before_action :assign_workshop, only: [:show, :edit, :update, :confirm]

  def index
    @workshops = Workshop.where user: current_user
  end

  def new
    @workshop = Workshop.new
  end

  def create
    @workshop = current_user.workshops.build workshop_params

    if @workshop.save
      after_save_redirection
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @workshop.update workshop_params
      after_save_redirection
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def confirm
    @workshop.touch :confirmed_at
    redirect_to @workshop, notice: I18n.t(:workshop_was_successfully_confirmed)
  end

  private

  def assign_workshop
    @workshop = current_user.workshops.find params[:id]
  end

  def workshop_params
    params.require(:workshop).permit [:title, :subtitle, :length, :language, :abstract, :description, :notes, :track_id, :agreement]
  end

  def after_save_redirection
    if current_user.speaker_profile.present?
      redirect_to @workshop
    else
      redirect_to edit_user_registration_path, alert: I18n.t(:please_fill_in_your_speaker_profile)
    end
  end
end
