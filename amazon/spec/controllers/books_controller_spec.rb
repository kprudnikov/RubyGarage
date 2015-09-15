require "rails_helper"

describe BooksController do
  let (:customer) {create(:customer)}

  describe "#index" do
    let (:books) {create_list(:book, 5) }
    before { get :index }

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
      end

      it "redirects to sign in page" do
        expect(response).to redirect_to(new_customer_session_path)
      end

      it "shows alert flash" do
        expect(flash[:alert]).not_to be(nil)
      end
    end

    describe "with registered customer" do
      login_customer
      before { post :create, book: attributes_for(:book) }

      it "doesn't call create method on Book" do
        expect(Book).not_to receive(:create)
      end

      it "redirects to root page" do
        expect(response).to redirect_to(root_path)
      end

      it "shows alert flash" do
        expect(flash[:alert]).not_to be_nil
      end
    end

    describe "with admin" do
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
    let(:book){ create :book }
    before do
      allow(Book).to receive(:find).and_return(book)
    end

    describe "with non registered customer" do
      before{ get :edit, id: book.id }

      it "doesn't call find on Book" do
        expect(Book).not_to receive(:find)
      end

      it "redirects to sign_in page" do
        expect(response).to redirect_to(new_customer_session_path)
      end
    end

    describe "with registered customer" do
      login_customer
      before{ get :edit, id: book.id }

      it "doesn't call find on Book" do
        expect(Book).not_to receive(:find)
      end

      it "redirects to root page" do
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with admin" do
      login_admin
      before{ get :edit, id: book.id }

      it "sets @book to requested book" do
        expect(assigns(:book)).to match(book)
      end

      it "renders 'edit' view" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "#update" do
    let(:book){ create :book }
    before do
      allow(Book).to receive(:find).and_return(book)
      allow(book).to receive(:update)
    end

    describe "with non registered customer" do
      before {patch :update, id: book.id, book: attributes_for(:book)}

      it "doesn't call find on Book" do
        expect(Book).not_to receive(:find)
      end

      it "doesn't call update on book" do
        expect(book).not_to receive(:update)
      end

      it "redirects to sign in page" do
        expect(response).to redirect_to(new_customer_session_path)
      end
    end

    describe "with registered customer" do
      login_customer
      before {patch :update, id: book.id, book: attributes_for(:book)}

      it "doesn't call find on Book" do
        expect(Book).not_to receive(:find)
      end
      it "doesn't call update on book" do
        expect(book).not_to receive(:update)
      end
      it "redirects to root page" do
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with admin", :focus do
      login_admin

      def send_request
        patch :update, id: book.id, book: attributes_for(:book)
      end

      it "calls find on Book" do
        expect(Book).to receive(:find)
        send_request
      end
      it "calls update on book" do
        expect(book).to receive(:update)
        send_request
      end
      it "assigns @book to book" do
        send_request
        expect(assigns(:book)).to match(book)
      end
      it "redirects to show page" do
        send_request
        expect(response).to redirect_to(book_path book)
      end
    end
  end
end