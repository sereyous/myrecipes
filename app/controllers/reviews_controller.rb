class ReviewsController < ApplicationController 
  def index 
     
  end
   
  def new
    # binding.pry
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new 
  end
   
  def create 
    binding.pry
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
end