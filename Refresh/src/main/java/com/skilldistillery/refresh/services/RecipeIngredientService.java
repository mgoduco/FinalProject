package com.skilldistillery.refresh.services;

import java.util.List;

import org.springframework.web.bind.annotation.RequestBody;

import com.skilldistillery.refresh.entities.RecipeIngredient;

//THIS NEEDS TA ADVICE BEFORE CONTINUING WITH COMPOUND-KEY TABLE

public interface RecipeIngredientService {
	
//	public List<Recipe> index();
//	
//	public List<Recipe> getRecipesByUser(String username);
//
//	public Recipe show(String username, int recipeId);
//
//	public Recipe create(String username, Recipe recipe);
//
//	public Recipe update(String username, Recipe recipe, int recipeId);
//
//	public boolean delete(String username, int trailId);
//	
//	public Recipe getRecipeById(int id);
//	
//	public List<Recipe> getRecipeByIngredients();
//	
//	public List<Recipe> getRecipeByKeyword();
//	
//	public List<Recipe> getRecipeBySomething();
	
	List<RecipeIngredient> getRecipeIngredients(int recipeId);

	RecipeIngredient createForRecipe(String username, int recipeId, int ingredientId,
			RecipeIngredient recipeIngredient);
	
	RecipeIngredient getByRecipeIdAndIngredientId(int recipeId, int ingredientId);
	
	
}
