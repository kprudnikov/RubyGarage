require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  before {allow(Order).to receive(:find).and_return(order)}

  describe "#addresses" do

    let (:customer){create :customer}
    let (:order) {customer.order_in_progress}

    describe "with registered customer" do
      before  do
        sign_in customer
        get :addresses, order_id: order.id
      end

      it "renders addresses view" do
        expect(response).to render_template(:addresses)
      end

      it "assigns billing and shipping address" do
        expect(order.billing_address).not_to be_nil
        expect(order.shipping_address).not_to be_nil
      end
    end

    describe "with unauthorised user" do
      before do
        get :addresses, order_id: order.id
      end

      it "redirects to sign in page" do
        expect(response).to redirect_to(new_customer_session_path)
      end

      it "doesn't assign billing or shipping addresses" do
        expect(order.billing_address).to be_nil
        expect(order.shipping_address).to be_nil
      end
    end

    describe "with admin" do
      login_admin
      before do
        get :addresses, order_id: order.id
      end

      it "renders addresses view" do
        expect(response).to render_template(:addresses)
      end

      it "assigns billing and shipping address" do
        expect(order.billing_address).not_to be_nil
        expect(order.shipping_address).not_to be_nil
      end
    end
  end

  describe "#set_addresses" do
    let (:customer){create :customer}
    let (:order) {customer.order_in_progress}
    let (:billing_address){create :address}
    let (:shipping_address){create :address}

    def send_valid_request
      post :set_addresses,
      order_id: order.id,
      billing_address: attributes_for(:address).stringify_keys,
      shipping_address: attributes_for(:address).stringify_keys
    end

    def send_invalid_request
      post :set_addresses,
      order_id: order.id,
      billing_address: {"city" => "City"},
      shipping_address: {"address" => "Test address"}
    end

    describe "with unauthorised customer" do
      before {send_valid_request}

      it "redirects to sign_in page" do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_customer_session_path)
      end
    end

    describe "with authorised customer" do
      before do
        sign_in customer
      end

      it "sets @order to order" do
        send_valid_request
        expect(assigns[:order]).to match(order)
      end

      it "redirects to next checkout step if addresses are valid" do
        send_valid_request
        expect(response).to redirect_to(order_delivery_service_path(order))
      end

      it "renders addresses page if addresses are invalid" do
        send_invalid_request
        expect(response).to render_template(:addresses)
      end

    end

    describe "with admin" do
      login_admin

      it "sets @order to order" do
        send_valid_request
        expect(assigns[:order]).to match(order)
      end

      it "redirects to next checkout step if addresses are valid" do
        send_valid_request
        expect(response).to redirect_to(order_delivery_service_path(order))
      end

      it "renders addresses page if addresses are invalid" do
        send_invalid_request
        expect(response).to render_template(:addresses)
      end
    end

  end

end