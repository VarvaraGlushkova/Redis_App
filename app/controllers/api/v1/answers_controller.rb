class Api::V1::AnswersController < ApplicationController


  def index
    @answers = Answer.all
  end

  def show
      @answer = Answer.includes(:images, :comments).find(params[:id])
      render json: @answer.as_json(
        only: [:id, :user_name, :description, :answer_img, :task_id, :user_id])
  end

  private

   def answer_params
      params.require(:answer).permit(:user_name, :description, :answer_img, :task_id, :user_id)
   end

    def encrypt_payload
      payload = @user.as_json(only: [ :email, :jti ])
      token = JWT.encode(payload, Rails.application.credentials.devise_jwt_secret_key!, "HS256")
    end

    def decrypt_payload
      jwt = request.headers["Authorization"]
      token = JWT.decode(jwt, Rails.application.credentials.devise_jwt_secret_key!, true, { algorithm: "HS256" })
    end
end
