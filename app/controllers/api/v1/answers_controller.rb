class Api::V1::AnswersController < ApplicationController
  def index
    @answers = Answer.all
    # render json: @posts
    # render json: @posts.as_json
  end

  def show
    @answer = Answer.find(params[:id])
    @comment = @answer.comments
  end
end
