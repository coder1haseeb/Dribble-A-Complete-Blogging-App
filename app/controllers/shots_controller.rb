class ShotsController < ApplicationController
  before_action :authenticate_user! , except: [:index , :show , :like , :unlike]
  before_action :set_shot, only: %i[show edit update destroy like unlike]
  impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :user_id]
  before_action :validate_owner, only: %i[edit update destroy]

  # GET /shots or /shots.json
  def index
    @shots = Shot.all.order("created_at DESC")
  end

  # GET /shots/1 or /shots/1.json
  def show
  end

  # GET /shots/new
  def new
    @shot = current_user.shots.build
  end
  
  # GET /shots/1/edit
  def edit
  end
  
  # POST /shots or /shots.json
  def create
    @shot = current_user.shots.build(shot_params)
    @shot.user_id = current_user.id
    
    if @shot.save
      redirect_to shot_url(@shot), notice: "Shot was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /shots/1 or /shots/1.json
  def update
    if @shot.update(shot_params)
      redirect_to shot_url(@shot), notice: "Shot was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /shots/1 or /shots/1.json
  def destroy
    @shot.destroy
    redirect_to shots_url, notice: "Shot was successfully destroyed."
  end

  def my_shots
    if user_signed_in?
      @shots = current_user.shots.all
      @shot = Shot.new
    end
  end

  def like
    @shot.liked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js {render layout:false}
    end
  end
  
  def unlike
    @shot.unliked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js {render layout:false}
    end
  end
  private

  def validate_owner
    if @shot.user_id != current_user.id
      return redirect_to root_path, notice: 'You are not authorized to manipulate this shot'
    end
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_shot
    @shot = Shot.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def shot_params
    params.require(:shot).permit(:title, :description, :user_id, :image)
  end
end
