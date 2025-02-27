class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authenticate_guest
    if current_user
      if cookies[:guest_token]
        @guest = Guest.find_by_jti(cookies[:guest_token])
        @cart = @guest.carts.first

        if current_user.carts.any?
          if @cart.products.any?
            current_user.carts.first.destroy!
            @cart.update!(cartable_type: "User", cartable_id: current_user.id)
          else
            @cart = current_user.carts.first
          end
        else
          @cart.update!(cartable_type: "User", cartable_id: current_user.id)
        end

        @guest.destroy!
        cookies.delete(:guest_token)
      else
        if current_user.carts.any?
          @cart = current_user.carts.first
        else
          @cart.create!(cartable_type: "User", cartable_id: current_user.id)
        end
      end
    else
      if cookies[:guest_token]
        jti = cookies[:guest_token]
        @guest = Guest.find_by_jti(jti)
        @cart = @guest.carts.last

        puts "GUEST TOKEN"
        puts jti
      else
        puts "NO TOKEN"
        jti = SecureRandom.uuid
        @guest = Guest.create!(jti: jti)
        @cart = @guest.carts.last
        cookies[:guest_token] = jti
      end
    end

    # cookies.delete(:guest_token)
  end


  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to root_path, alert: exception.message }
    end
  end
end
