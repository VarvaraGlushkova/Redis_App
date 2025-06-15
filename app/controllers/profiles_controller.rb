class ProfilesController < ApplicationController
  before_action :authenticate_user!, :set_profile

  # GET /profiles or /profiles.json
  def index
    @profiles = Profile.includes(:user)
    @profile_post_counts = Post.group(:user_id).count
  end

  # GET /profiles/1 or /profiles/1.json
  def show
    # @profile = Profile.find(params[:id])
    @profile = current_user.profile
    @user = @profile.user
    @answers = @user.answers
    @tasks = @user.tasks
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy
    @profile.destroy!

    respond_to do |format|
      format.html { redirect_to profiles_path, status: :see_other, notice: "Profile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      if current_user
        @profile = current_user.profile || current_user.create_profile!
        @profile.user_id = current_user.id
      else
        @profile = Profile.find_by(id: params[:id]) if params[:id]
      end
    end

    def profile_params
      params.require(:profile).permit(:id, :name, :bio, :avatar, :user_id)
    end
end
