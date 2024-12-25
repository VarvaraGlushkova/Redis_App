class Api::V1::CommentsController < ApplicationController
  def index
    @comments = Comment.all
    # render json: @posts
    # render json: @posts.as_json
  end
end
