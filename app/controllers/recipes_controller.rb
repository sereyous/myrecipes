class RecipesController < ApplicationController 
  before_action :set_recipe, only: [:show, :edit, :update, :like, :review]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_user_like, only: [:like]
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  
  def index 
    @recipes = Recipe.paginate(page: params[:page], per_page: 2)
  end
  
  def show 
    #binding.pry
  end
  
  def new 
    @recipe = Recipe.new
  end
  
  def create 
    # binding.pry
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user
    
    if ( @recipe.save )
      flash[:success] = "Your recipe was created successfully"
      redirect_to recipes_path
    else 
      render :new
    end
  end
  
  def edit 
  end
  
  def update 
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully"
      redirect_to recipe_path(@recipe)
    else 
      render :edit
    end
    
  end
  
  def destroy 
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe Deleted"
    redirect_to recipes_path
  end
  
  def like 
    like = Like.create(like: params[:like], recipe: @recipe, chef: current_user)
    if like.valid?
      flash[:success] = "Your selection was successful"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_to :back
    end
  end
  
  def review 
  end
  
  private 
    def set_recipe 
      @recipe = Recipe.find(params[:id])
    end
    
    def require_same_user
      if current_user != @recipe.chef && !current_user.admin?
        flash[:danger] = "You can only edit your own profile"
        redirect_to recipes_path
      end
    end
  
    def require_user_like
      if !logged_in?
        flash[:danger] = "You must be logged in to perform that action"
        redirect_to :back
      end
    end
  
    def recipe_params
      params.require(:recipe).permit(:name,:summary,:description,:picture, style_ids: [], ingredient_ids: [] )      
    end
    
    def admin_user 
      redirect_to recipes_path unless current_user.admin?
    end
end