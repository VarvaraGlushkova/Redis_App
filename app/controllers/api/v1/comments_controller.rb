class Api::V1::CommentsController < ApplicationController

  before_action :set_answer
  before_action :authenticate_user!

  
  def index
    @comments = Comment.all
    # render json: @posts
    # render json: @posts.as_json
  end
end
