class RegistrationsController < Devise::RegistrationsController

  def edit
    @billing_address = current_customer.billing_address || Address.new
    @shipping_address = current_customer.shipping_address || Address.new
    @countries = Country.all
  end

  private

  def sign_up_params
    params.require(:customer).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:customer).permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password)
  end
end