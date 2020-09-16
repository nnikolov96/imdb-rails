class ReviewsController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)

    if @review.save
      redirect_to @movie, notice: 'Review Submitted'
    else
      flash.now[:alert] = 'Review could not be created'
      render :new
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:comment, :stars).merge(user: current_user)
  end
end
