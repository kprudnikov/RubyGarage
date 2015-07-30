class RatingsController < ApplicationController
  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      flash[:success] = "Review successfully added"
    else
      flash[:alert] = "Error. Review wasn't added"
    end
    redirect_to book_path(@rating.book)
  end

private

  def rating_params
    params.require(:rating).permit([:review, :rating, :customer_id, :book_id])
  end
end
