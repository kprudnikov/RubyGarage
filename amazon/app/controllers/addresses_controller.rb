class AddressesController < ApplicationController

  def index
    @addresses = Address.all
  end

  def new
    @address = Address.new
    @countries = Country.all
  end

  def create
    @address = Address.new(create_address_params)

    case address_type
    when "shipping_address"
      if @address.save
        current_customer.shipping_address = @address
        if current_customer.save
          flash[:success] = "Address successfully saved"
        else
          @address.delete
          current_customer.shipping_address = nil
          flash[:alert] = "Address was not saved"
        end
      else
        flash[:alert] = "Address was not saved"
      end
    when "billing_address"
      if @address.save
        current_customer.billing_address = @address
        if current_customer.save
          flash[:success] = "Address successfully saved"
        else
          @address.delete
          current_customer.billing_address = nil
          flash[:alert] = "Address was not saved"
        end
      else
        flash[:alert] = "Address was not saved"
      end
    else
      flash[:alert] = "Wrong address type"
    end

    redirect_to request.referrer
  end

  def update
    @address = Address.find(params[:id])
    @address.update(create_address_params)
    redirect_to request.referrer
  end

private

  def address_type
    params[:address][:address_type]
  end

  def create_address_params
    puts params
    params.require(:address).permit(:address, :zipcode, :city, :phone, :country_id)
  end

end
