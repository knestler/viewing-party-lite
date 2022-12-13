# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @viewing_parties = @user.viewing_parties
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user)
    elsif user_params[:password] != user_params[:password_confirmation]
      redirect_to '/register'
      flash[:alert] = 'ERROR: Passwords must match'
    elsif user_params[:name].blank? && !user_params[:email].blank?
      redirect_to '/register'
      flash[:alert] = 'ERROR: Please enter a valid name'
    elsif !user_params[:name].blank? && user_params[:email].blank?
      redirect_to '/register'
      flash[:alert] = 'ERROR: Please enter a valid email'
    elsif user_params[:name].blank? && user_params[:email].blank?
      redirect_to '/register'
      flash[:alert] = 'ERROR: Please enter a valid name and email'
    elsif !user_params[:name].blank? && user.errors[:email]
      redirect_to '/register'
      flash[:alert] = 'ERROR: Email already in use. Please enter a different email'
    end
  end
  
  def discover
    @user = User.find(params[:id])
  end

  def results
    @user = User.find(params[:user_id])

    @movies = if params['Find Movies'].present?
                MovieService.movies_by_keyword(params['Find Movies'])
              else
                MovieService.find_top_rated_movies
              end
  end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
