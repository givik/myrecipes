require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "givik", email: "giviko@live.com",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "vegetable saute", description: "greate vegetable saute", chef: @chef)
  end
  
  test "successfully delete a recipe" do
    sign_in_as(@chef, "password")
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_select 'a[href=?]', recipe_path(@recipe)
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)      
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end
end
