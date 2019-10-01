class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort = params[:sort] || session[:sort] 
    if !params[:sort].nil?
      session[:sort] = params[:sort]
    end
    
    @all_ratings = ['G','PG','PG-13','R','NC-17']
    @ratings = params[:ratings] || session[:ratings]
    if !params[:ratings].nil? #If a user unchecks all checkboxes, use the settings stored in the session[] hash
      session[:ratings] = params[:ratings] #new settings should be remembered in the session
    end
    
    if @ratings
      @movies = Movie.with_ratings(@ratings.keys).order @sort # a class-level method in the model
      #go in the model rather than exposing details of the schema to the controller
    else
      @movies = Movie.order @sort
    end
    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
