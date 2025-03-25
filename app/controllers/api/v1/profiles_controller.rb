class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile
  
  # GET /profiles or /profiles.json
  def index
    @profiles = Profile.includes(:user)
    # @profile_post_counts = Post.group(:user_id).count
  end

  # GET /profiles/1 or /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
    @answers = @user.answers
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.includes(
        user: [
          :answers,
          # :tasks
        ]
      ).find(params[:id])
    end


    def profile_params
      params.require(:profile).permit(:id, :name, :bio, :avatar, :user_id)
    end
end