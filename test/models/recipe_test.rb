# == Schema Information
#
# Table name: recipes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  summary     :text
#  description :text
#  chef_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  picture     :string(255)
#

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create(chefname: "Bob", email: "bob@example.com")
    @recipe = @chef.recipes.build(name: "chicken parm", summary: "classic italian dish", 
              description: "heat oil, add onions, add tomato sauce, add chicken, cook for 20 minutes")
  end
  
  test "recipe should be valid" do 
    assert @recipe.valid?
  end
  
  test "chef_id should be present" do 
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test "name should be present" do 
    @recipe.name = ''
    assert_not @recipe.valid?
  end
  
  test "name length should not be too long" do 
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end

  test "name length should not be too short" do 
    @recipe.name = "aaaa"
    assert_not @recipe.valid?
  end
  
  test "summary should be present" do 
    @recipe.summary = ''
    assert_not @recipe.valid?
  end
  
  test "summary length should not be too long" do 
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end
  
  test "summary length should not be too short" do 
    @recipe.summary = "a" * 9
    assert_not @recipe.valid?
  end
  
  test "description should be present" do 
    @recipe.description = ''
    assert_not @recipe.valid?
  end
  
  test "description length should not be too long" do 
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
  test "description length should not be too short" do 
    @recipe.description = "a" * 19
    assert_not @recipe.valid?
  end
end
