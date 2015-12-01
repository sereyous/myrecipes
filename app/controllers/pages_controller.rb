class PagesController < ApplicationController
  def home
    redirect_to chef_path(session[:chef_id]) if logged_in?
  end
end