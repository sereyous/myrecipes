# == Schema Information
#
# Table name: recipe_ingredients
#
#  id            :integer          not null, primary key
#  ingredient_id :integer
#  recipe_id     :integer
#

class RecipeIngredient < ActiveRecord::Base 
  belongs_to :ingredient
  belongs_to :recipe
end
