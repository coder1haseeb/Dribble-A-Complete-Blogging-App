class RegistrationsController < Devise::RegistrationsController

    private

    def sign_up_params
        params.require(:user).permit(:name , :email , :password,:password_confirmation , :image)
    end

    def account_update_params
        params.require(:user).permit(:name , :email , :password,:password_confirmation , :current_password , :image)
    end

end