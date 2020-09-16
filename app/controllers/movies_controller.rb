class MoviesController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]
  before_action :set_movie, only: %i[show edit update destroy]

  def index
    @movies = Movie.released
  end

  def show
    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie was created successfully'
    else
      flash.now[:alert] = 'Movie could not be created'
      render :new
    end
  end

  def edit; end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie was updated'
    else
      flash.now[:alert] = 'Movie could not be updated'
      render :edit
    end
  end

  def destroy
    if @movie.destroy
      flash[:notice] = 'Movie was deleted'
    else
      flash[:notice] = 'We could not delete this movie'
    end
    redirect_to movies_path
  end

  private

  def set_movie
    @movie = Movie.includes(:fans).find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :released_on, :description, :total_gross, :director, :duration, :image_file_name)
  end

  
end
