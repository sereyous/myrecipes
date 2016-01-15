class ChefsController < ApplicationController 
  before_action :set_chef, only: [:edit, :update, :show, :reviews]
  before_action :require_same_user, only: [:edit, :update]
  
  def index 
    redirect_to login_path unless logged_in?
    @chefs = Chef.paginate(page: params[:page], per_page: 2)  
  end
  
  def new 
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    
    if @chef.save
      flash[:success] = "Your account has been created successfully"
      redirect_to recipes_path
    else
      render 'new'
    end
  end
  
  def edit 
  end
  
  def update 
    if  @chef.update(chef_params)
      flash[:success] = "Your profile has been updated successfully"
      redirect_to chef_path(@chef)
    else
      render 'edit'
    end    
  end
  
  def show 
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 2)
  end
  
  def reviews 
      @reviews = @chef.reviews
  end
  
  private
    def set_chef 
      @chef = Chef.find(params[:id])
    end
    
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end
    
    def require_same_user
      if current_user != @chef
        flash[:danger] = "You can only edit your own profile"
        redirect_to root_path
      end
    end
end