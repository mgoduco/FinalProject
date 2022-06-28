package com.skilldistillery.refresh.services;

import java.util.List;

import com.skilldistillery.refresh.entities.Recipe;

public interface RecipeService {
	
	public List<Recipe> index();
	
	public List<Recipe> getRecipesByUser(String username);

//	public Recipe show(String username, int recipeId);
	public Recipe show(int recipeId);

	public Recipe create(String username, Recipe recipe);

	public Recipe update(String username, Recipe recipe, int recipeId);

	public boolean delete(String username, int trailId);
	
	public Recipe getRecipeById(int id);
	
	public List<Recipe> getRecipeByName(String keyword);
	
	public List<Recipe> getRecipeByKeyword();
	
	public List<Recipe> getRecipeBySomething();

	List<Recipe> getRecipeByIngredients(String ingredient);
	
	List<Recipe> getRecipeByNameAndIngredients(String keyword, String ingredient);

	Recipe getFavoriteRecipeByUsernameAndId(String username, int recipeId);

	
	
}
