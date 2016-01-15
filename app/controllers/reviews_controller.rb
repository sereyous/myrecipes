class ReviewsController < ApplicationController 
  before_action :already_reviewed, only: [:new]
  
  def index 
     
  end
   
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new 
  end
   
  def create 
    @review = Review.new(review_params)
    @review.chef = current_user
    @review.recipe_id = params[:recipe_id]
    
    if @review.save
      flash[:success] = "Your review was successfully saved"
      redirect_to recipe_path(@review.recipe)
    else
      flash[:danger] = "There was a problem saving your review"
      redirect_to :back
    end
  end
  
  def edit 
    @review = Review.find(params[:id])
    @recipe = @review.recipe
  end
   
  def show 
  end
   
  def update 
  end
   
  def destroy 
  end
   
  private 
    def review_params
      params.require(:review).permit(:title, :body)
    end
    
    def already_reviewed
      review = Review.where('recipe_id = ? AND chef_id = ?', params[:recipe_id], current_user.id).first
      if review 
        flash[:warning] = "You have already reviewed this recipe. You can edit your recipe below."
        redirect_to edit_review_path(review)
      end
    end
end