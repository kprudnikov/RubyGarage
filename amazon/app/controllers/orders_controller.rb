class OrdersController < ApplicationController

  before_action :authenticate_customer!
  skip_before_action :check_editable, only: [:index]

  def index
    if current_customer.admin?
      # @orders = Order.find_by!(state: "in_progress")
      @orders = Order.where("state != 'in_progress'")
    else
      @orders = current_customer.orders.select{|o| o.state != "in_progress"}
    end
  end

  def show
    begin
      @order = Order.find(params[:id])
      if !current_customer.admin? && !current_customer.orders.include?( @order )
        flash[:alert] = "Access denied"
        redirect_to order_path(current_customer.order_in_progress)
      end
    rescue
      flash[:alert] = "Order not found"
      redirect_to root_path
    end
  end

  def update
    @order = Order.find(params[:id])
    if !(current_customer.order_in_progress == @order)
      flash[:alert] = "Access denied"
      redirect_to request.referrer
    else
      update_order_params.each do |item|
        @order.order_items.update(item["id"], {id: item["id"], quantity: item["quantity"]})
      end
      @order.total_price = @order.order_items.inject(0){|sum, item| sum + item.book.price*item.quantity}
      if @order.save
        flash[:success] = "Order updated"
      else
        flash[:alert] = "Update failed"
      end
      redirect_to order_path(@order)
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if current_customer.order_in_progress == @order || current_customer.admin?
      if @order.destroy
        flash[:success] = "Cart is cleared"
        redirect_to root_path
      else
        flash[:success] = "Error"
        redirect_to order_path @order
      end
    end
  end

  def addresses
    @customer = current_customer
    @order = @customer.orders.find(params[:order_id]) || @customer.order_in_progress

    @billing_address = @order.billing_address || (@customer.billing_address ? @customer.billing_address.dup : Address.new)
    @shipping_address = @order.shipping_address || (@customer.shipping_address ? @customer.shipping_address.dup : Address.new)

    @countries = Country.all
  end

  def set_addresses
    @order = current_customer.orders.find(params[:order_id]) || current_customer.order_in_progress

    if !@order.billing_address
      @order.billing_address = Address.new
    end
    if !@order.shipping_address
      @order.shipping_address = Address.new
    end

    @order.billing_address.update(billing_address_params)
    @order.shipping_address.update(shipping_address_params)

    if @order.billing_address.valid? && @order.shipping_address.valid? && @order.save
      flash[:success] = "Addresses saved"
      redirect_to order_delivery_service_path(@order)
    else
      flash[:alert] = "Please fill in all fields"
      redirect_to request.referrer
    end
  end

  def choose_delivery_service
    @order = current_customer.orders.find(params[:order_id]) || current_customer.order_in_progress
    @delivery_services = DeliveryService.all
  end

  def set_delivery_service
    @order = current_customer.orders.find(params[:order_id]) || current_customer.order_in_progress
    @order.total_price += DeliveryService.find(delivery_service_params[:delivery_service_id]).cost
    if @order.update(delivery_service_params)
      flash[:success] = "Delivery service saved"
      redirect_to order_credit_card_path(@order)
    else
      flash[:alert] = "Something went wrong, that's all we know"
      redirect_to request.referrer
    end
  end

  def enter_credit_card
    @order = current_customer.orders.find(params[:order_id]) || current_customer.order_in_progress
    @credit_card = @order.credit_card || CreditCard.new
  end

  def set_credit_card
    @order = current_customer.orders.find(params[:order_id]) || current_customer.order_in_progress
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
    @order = current_customer.orders.find(params[:order_id]) || current_customer.order_in_progress

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
    @order = current_customer.orders.find(params[:order_id]) || current_customer.order_in_progress

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

  def create_order_item_params
    params.permit([:book_id, :quantity])
  end

  def update_order_params
    params["order"]["order_items"]
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

  def check_editable
    @order = Order.find(params[:id])
    if !current_customer.admin? && (@order.state != "in_progress" || !current_customer.orders.find(@order.id))
      flash[:alert] = "Access denied"
      redirect_to root_path
    end
  end

end