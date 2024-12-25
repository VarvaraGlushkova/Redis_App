class Api::V1::ThemesController < ApplicationController
  def index
    @themes = Theme.all
    # render json: @posts
    # render json: @posts.as_json
  end

  def show
    @theme = Theme.find(params[:id])
    @task = @theme.tasks
  end
end
