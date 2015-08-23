require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  let(:customer){create :customer}
  let(:order){customer.orders.last}
  let(:other_customer){create(:customer)}
  let(:other_order){other_customer.orders.last}
  let(:order_item){create :order_item, order: order}

  describe "#show" do
    describe "with own order" do
      before do
        sign_in customer
        get :show, id: order.id 
      end

      it "responds with code 200" do
        expect(response).to have_http_status(200)
      end

      it "renders show page" do
        expect(response).to render_template(:show)
      end
    end

    describe "with other customer's order" do
      before do
        sign_in customer
        get :show, id: other_order.id 
      end

      it "responds with code 302" do
        expect(response).to have_http_status(302)
      end

      it "redirects to home page" do
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with admin" do
      login_admin
      before{get :show, id: order.id}

      it "responds with code 200" do
        expect(response).to have_http_status(200)
      end

      it "renders show page" do
        expect(response).to render_template(:show)
      end
    end
  end

  describe "#update" do

    before do
      allow(Order).to receive(:find).with(order.id.to_s).and_return(order)
      allow(Order).to receive(:find).with(other_order.id.to_s).and_return(other_order)
      allow(order).to receive(:save)
    end

    describe "with own order" do
      
      def update_post
        post :update, id: order.id, order: {order_items: [{id: order_item.id, quantity: order_item.quantity}]}
      end

      before do
        sign_in customer
      end

      it "assigns @order to order" do
        update_post
        expect(assigns[:order]).to match(order)
      end

      it "calls update on order items" do
        # this is impossible to test
      end

      it "saves order" do
        expect(order).to receive(:save)
        update_post
      end

      it "redirects to order page" do
        update_post
        expect(response).to redirect_to(order_path(order))
      end
    end

    describe "with other customer's order" do
      before do
        sign_in customer
        post :update, id: other_order.id, order: {order_items: [{id: order_item.id, quantity: order_item.quantity}]}
      end

      it "assigns @order to other customer's order" do
        expect(assigns[:order]).to match(other_order)
      end

      it "redirects to root_path" do
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with admin" do
      login_admin

      before do
        post :update, id: order.id, order: {order_items: [{id: order_item.id, quantity: order_item.quantity}]}
      end

      it "redirects to order page" do
        expect(response).to redirect_to(order_path order)
      end

      it "assigns @order to order" do
        expect(assigns[:order]).to match(order)
      end
    end
  end

  describe "#destroy" do
    describe "with own order" do
    end

    describe "with other customer's order" do
    end

    describe "with admin" do
    end

  end

  describe "#set_state", :focus do


    describe "without admin rights" do

      before(:each) do
        post :set_state, order_id: order.id, order: {state: "in_queue"}
      end

      before { sign_in customer }

      it "doesn't assign @order" do
        expect(assigns[:order]).to be_nil
      end
      it "redirects to previous page" do
        expect(response).to redirect_to(new_customer_session_path)
      end
      it "shows alert message" do
        expect(flash[:alert]).not_to be_nil
      end
    end

    describe "with admin rights" do
      login_admin

      before do 
        allow(controller.request).to receive(:referrer).and_return(root_path)
      end

      it "assigns @order to order" do
        post :set_state, order_id: order.id, order: {state: "in_queue"}
        expect(assigns[:order]).to match(order)
      end
      it "doesn't show an error when transition is correct" do
        post :set_state, order_id: order.id, order: {state: "in_queue"}
        expect(flash[:alert]).to be_nil
      end
      it "shows error when transition is incorrect" do
        post :set_state, order_id: order.id, order: {state: "delivered"}
        expect(flash[:alert]).not_to be_nil
      end
    end

  end

  describe "#manage" do
    describe "without admin rights" do

      before do
        allow(controller.request).to receive(:referrer).and_return(root_path)
        sign_in customer
        get :manage
      end

      it "doesn't assign @orders" do
        expect(assigns[:orders]).to be_nil
      end
      it "shows alert flash" do
        expect(flash[:alert]).not_to be_nil
      end
      it "redirect_to previous page" do
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with admin rights" do
      login_admin

      before do
        get :manage
      end

      it "assigns @orders to all orders" do
        expect(assigns[:orders]).not_to be_nil
      end
      it "renders manage page" do
        expect(response).to render_template("manage")
      end
    end

  end
end