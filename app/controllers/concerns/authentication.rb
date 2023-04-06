module Authentication
    extend ActiveSupport::Concern

    included do
        private

        def current_user
            if session[:user_id].present?
                @current_user ||= User.find_by(id: session[:user_id]).decorate
            elsif cookies.encrypted[:user_id].present?
                user = User.find_by(id: cookies.encrypted[:user_id])
                if user&.remember_token_auth?(cookies.encrypted[:remember_token])
                    sign_in(user)
                    @current_user ||= user.decorate
                end
            end
        end

        def user_signed_in?
          current_user.present?
        end

        def sign_in(user)
            session[:user_id] = user.id
        end

        def require_auth_false
            return unless user_signed_in?
            flash[:warning] = "You are already signed in!"
            redirect_to root_path
        end

        def require_auth_true
            return if user_signed_in?
            flash[:warning] = "You are not signed in!"
            redirect_to root_path
        end

        def sign_out
            forget current_user
            session.delete :user_id
            @current_user = nil
        end

        def remember(user)
            user.remember_me
            cookies.encrypted[:remember_token] = user.remember_token
            cookies.encrypted[:user_id] = user.id

            cookies.encrypted[:remember_token] = {expires: 1.hours}
            cookies.encrypted[:user_id] = {expires: 1.hours}
        end

        def forget(user)
            user.forget_me
            cookies.delete :user_id
            cookies.delete :remember_token
        end

        helper_method :current_user, :user_signed_in?

    end
end