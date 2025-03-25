class Api::V1::CommentsController < ApplicationController

  before_action :set_answer
  before_action :authenticate_user!

  def index
    comments = @effect.comments.includes(:user)
    render json: format_comments(comments)
  end

  def show
    comment = @answer.comments.includes(:user).find_by(id: params[:id])
    
    if comment
      render json: format_comment(comment)
    else
      render json: { error: "Комментарий не найден" }, status: :not_found
    end
  end

  def create
    comment = @answer.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      render json: { 
        message: "Комментарий создан", 
        comment: format_comment(comment),
      }, status: :created
    else
      render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    comment = @answer.comments.find_by(id: params[:id])
    return render json: { error: "Комментарий не найден" }, status: :not_found unless comment

    unless comment.user == current_user
      return render json: { error: "Вы не можете редактировать этот комментарий" }, status: :forbidden
    end

    if comment.update(comment_params)
      render json: { message: "Комментарий обновлён", comment: format_comment(comment) }, status: :ok
    else
      render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    comment = @answer.comments.find(params[:id])

    if comment.destroy
      render json: { message: "Комментарий удалён" }, status: :ok
    else
      render json: { error: "Ошибка удаления" }, status: :unprocessable_entity
    end

  private

  def set_answer
    @answer= Answer.find_by(:id)
    render json: { error: "Редизка не найдена((" }, status: :not_found unless @answer
  end

  def comment_params
    params.require(:comment).permit(:user_name_title, :body_content, :user_id, :answer_id)
  end

  def format_comments(comments)
    comments.map { |comment| format_comment(comment) }
  end

  def format_comment(comment)
    comment.as_json(only: [:id, :body_content, :created_at], include: { 
      user: { only: [:email, :admin] } 
    })
  end

  def current_user
    User.find_by_jti(decrypt_payload[0]['jti'])
  end

  def decrypt_payload
    jwt = request.headers["Authorization"]
    JWT.decode(jwt, Rails.application.credentials.devise_jwt_secret_key!, true, { algorithm: 'HS256' })
  end

end
