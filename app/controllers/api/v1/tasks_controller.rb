class Api::V1::TasksController < ApplicationController
  def index
    @tasks = Task.all
    # render json: @posts
    # render json: @posts.as_json
  end

  def show
    @task = Task.find(params[:id])
  end
end
