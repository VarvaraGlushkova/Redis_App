class LikesController < ApplicationController
  before_action :authenticate_user! # Assuming you have user authentication

  def create
    @likeable = find_likeable
    @like = current_user.likes.build(likeable: @likeable)

    if @like.save
      redirect_to @likeable, notice: "Liked!"
    else
      redirect_to @likeable, alert: "Error liking."
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to @like.likeable, notice: "Unliked."
  end

  private

  def find_likeable
    params[:likeable_type].constantize.find(params[:likeable_id])
  end
end