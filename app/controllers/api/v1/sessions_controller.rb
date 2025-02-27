class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user, only: [ :destroy ]

  efore_action :sign_in_params, only: :create
  before_action :load_user_by_email, only: :create
  before_action :load_user_by_jti, only: :destroy

  def create
    sign_in "user", @user
    # sign_in "user", @user

    if @user.valid_password?(sign_in_params[:password])
      render json: {
        messages: "Signed In Successfully",
        is_success: true,
        jti: @user.jti
      }, status: :ok
    else
      render json: {
        messages: "Sign In Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
  end

    def destroy
      # @user = User.find_by_jti(decrypt_payload[0]['jti'])

      if @user && @user.update_column(:jti, SecureRandom.uuid)
        render json: {
          messages: "Signed Out Successfully",
          is_success: true,
          data: {}
        }, status: :ok
      else
        render json: {
          # messages: "Signed Out Failed - Unauthorized",
          messages: "Sign Out Failed - Unauthorized",
          is_success: false,
          data: {}
        }, status: :unauthorized
      end
    end

    private

    def sign_in_params
      params.require(:user).permit(:email, :password)
    end


    def sign_out_params
      params.require(:user).permit(:jti)
    end

    def load_user_by_email
      @user = User.find_for_database_authentication(email: sign_in_params[:email])

      if @user
        @user
      else
        render json: {
          messages: "Sign In Failed - Unauthorized",
          is_success: false,
          data: {}
        }, status: :unauthorized
      end
    end


    def load_user_by_jti
      @user = User.find_by_jti(sign_out_params[:jti])

      if @user
        @user
      else
        render json: {
          messages: "Sign Out Failed - Unauthorized",
          is_success: false,
          data: {}
        }, status: :unauthorized
      end
    end
end
