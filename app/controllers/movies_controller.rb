# frozen_string_literal: true

class MoviesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @movie = MovieService.movie_by_id(params[:movie_id])
    @cast = MovieService.first_ten_cast(params[:movie_id])
    @reviews = MovieService.movie_reviews(params[:movie_id])
  end
end
