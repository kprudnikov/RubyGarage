class CheckoutController < ApplicationController
  before_action :get_current_order

  def addresses
    @customer = current_customer
    @order.billing_address = @order.build_billing_address
    @order.shipping_address = @order.build_shipping_address
    @countries = Country.all
  end

  def set_addresses

      if @order.billing_address
        @order.billing_address.update(billing_address_params)
      else
        @order.billing_address = Address.new(billing_address_params)
      end

      if @order.shipping_address
        @order.shipping_address.update(shipping_address_params)
      else
        @order.shipping_address = Address.new(shipping_address_params)
      end

      @countries = Country.all

    respond_to do |format|
      if @order.save && @order.billing_address.valid? && @order.shipping_address.valid?

        flash[:success] = "Addresses saved"
        format.html {redirect_to order_delivery_service_path(@order)}
      else
        flash.now[:alert] = "Please fill in all fields"
        format.html {render :addresses}
      end
    end
  end

  def choose_delivery_service
    @delivery_services = DeliveryService.all
  end

  def set_delivery_service
    @order.calculate_total_price
    if @order.update(delivery_service_params)
      flash[:success] = "Delivery service saved"
      redirect_to order_credit_card_path(@order)
    else
      flash[:alert] = "Something went wrong, that's all we know"
      redirect_to request.referrer
    end
  end

  def enter_credit_card
    @credit_card = @order.credit_card || CreditCard.new
  end

  def set_credit_card
    @order.credit_card ||= CreditCard.new

    if @order.credit_card.update(credit_card_params) && @order.save
      flash[:success] = "Credit card data saved"
      redirect_to order_confirmation_path
    else
      flash[:alert] = "Credit card data is invalid"
      redirect_to request.referrer
    end
  end

  def verify_data
    if !@order.billing_address ||
      !@order.billing_address.valid? ||
      !@order.billing_address ||
      !@order.billing_address.valid?

      flash[:alert] = "Something is wrong with the addresses. Please check"
      redirect_to order_checkout_address_path @order
      return
    end

    if !@order.delivery_service
      flash[:alert] = "Something is wrong with the delivery service. Please check"
      redirect_to order_delivery_service_path @order
      return
    end

    if !@order.credit_card || !@order.credit_card.valid?
      flash[:alert] = "Something is wrong with the credit card. Please check"
      redirect_to order_credit_card_path @order
      return
    end

    @card_number = @order.credit_card.number.split('').map.with_index do |d, i|
      (i >=  @order.credit_card.number.length - 4) ? d : "*"
    end
    @card_number = @card_number.join
  end

  def confirm
    if  @order.billing_address.valid? &&
        @order.shipping_address.valid? &&
        @order.delivery_service.valid? &&
        @order.credit_card.valid? &&
        @order.valid?

      @order.place
      @order.save
      flash[:success] = "Order has been placed"
      redirect_to root_path
    else
      flash[:alert] = "Order invalid"
      redirect_to request.referrer
    end
  end

private

  def get_current_order
    @order = Order.find(params[:order_id])

    if !current_customer.admin? && (@order.state != "in_progress" || !current_customer.orders.find(@order.id))
      flash[:alert] = "Access denied"
      redirect_to root_path
    end
  end

  def billing_address_params
    params.require(:billing_address).permit([:firstname, :lastname, :address, :zipcode, :phone, :city, :country_id])
  end

  def shipping_address_params
    params.require(:shipping_address).permit([:firstname, :lastname, :address, :zipcode, :phone, :city, :country_id])
  end

  def delivery_service_params
    params.require(:order).permit(:delivery_service_id)
  end

  def credit_card_params
    params.require(:credit_card).permit(:firstname, :lastname, :number, :cvv, :exp_month, :exp_year)
  end
end