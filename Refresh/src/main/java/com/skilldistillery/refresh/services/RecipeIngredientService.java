package com.skilldistillery.refresh.services;

import java.util.List;

import org.springframework.web.bind.annotation.RequestBody;

import com.skilldistillery.refresh.entities.Ingredient;
import com.skilldistillery.refresh.entities.Recipe;
import com.skilldistillery.refresh.entities.RecipeIngredient;

//THIS NEEDS TA ADVICE BEFORE CONTINUING WITH COMPOUND-KEY TABLE

public interface RecipeIngredientService {
	
	List<RecipeIngredient> getRecipeIngredients(int recipeId);

	RecipeIngredient getByRecipeIdAndIngredientId(int recipeId, int ingredientId);
	
	RecipeIngredient createForRecipe(String username, int recipeId, int ingredientId,
			RecipeIngredient recipeIngredient);
	
	RecipeIngredient editRecipeIngredient(String username, int iid, int rid, RecipeIngredient recipeIngredient);
	
	boolean deleteRecipeIngredient(String username, int rid, int iid);

	
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
	
	
}
