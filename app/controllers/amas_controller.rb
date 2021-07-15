class AmasController < ApplicationController
  include ApplicationHelper
  skip_before_action :authenticate_user!
  before_action :set_ama, only: %i[ show edit update destroy state_update ]

  def index
    @amas = Ama.includes(:speaker).all.order(:id)
  end

  def new
    @ama = Ama.new
  end

  def edit; end

  def create
    @ama = Ama.new(ama_params)

    respond_to do |format|
      if @ama.save
        format.html { redirect_to amas_path, notice: "Ama was successfully created." }
        format.json { render :show, status: :created, location: @ama }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ama.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ama.update(ama_params)
        format.html { redirect_to amas_path, notice: "Ama was successfully updated." }
        format.json { render :show, status: :ok, location: @ama }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ama.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ama.destroy
    respond_to do |format|
      format.html { redirect_to amas_url, notice: "Ama was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_ama
      @ama = Ama.find_by(id: params[:id])
    end

    def ama_params
      params.require(:ama).permit(:title, :start_date, :speaker_id)
    end
end
