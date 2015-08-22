require "rails_helper"

describe BooksController do

  let (:customer) {create(:customer)}


  describe "#index" do
    
    let (:books) {create_list(:book, 5) }

    before do 
      get :index
    end

    it "responds with 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "gets all books" do
      expect(assigns(:books)).to match_array(books)
    end

    it "renders 'index' view" do
      expect(response).to render_template(:index)
    end
  end

  describe "#create" do

    let(:book){create(:book)}

    before do
      allow(Book).to receive(:create).and_return(book)
    end

    describe "with non registered customer" do

      before {post :create}

      it "doesn't call create method on Book" do
        expect(Book).not_to receive(:create)
        post :create
      end

      it "redirects to sign in page" do
        expect(response).to redirect_to(new_customer_session_path)
      end

      it "shows alert flash" do
        expect(flash[:alert]).not_to be(nil)
      end
    end

    describe "with registered customer" do
      it "redirects to root page"
      it "shows alert flash"
    end

    describe "with admin", :focus do

      login_admin
      before { post :create, book: attributes_for(:book) }

      it "calls create method on Book" do
        expect(Book).to receive(:create)
        post :create, book: attributes_for(:book)
      end

      it "assigns @book to created book" do
        expect(assigns(:book)).to eq(book)
      end

      it "redirects to book's path" do
        expect(response).to redirect_to(book_path book)
      end
    end
  end

  describe "#edit" do
    describe "with non registered customer" do

    end

    describe "with registered customer" do

    end

    describe "with admin" do
      before do
        get :edit
        Book.stub(:find).and_return(book)
      end

      it "sets @book to requested book"
      it "renders 'edit' view"
    end
  end

  describe "#update" do
    describe "with non registered customer" do

    end

    describe "with registered customer" do

    end

    describe "with admin" do

    end
  end
end