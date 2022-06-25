package com.skilldistillery.refresh.services;

import java.util.List;
import java.util.Set;

import com.skilldistillery.refresh.entities.Ingredient;

public interface IngredientService {
	
	Ingredient getIngredientById(int id);
	
	Ingredient getIngredientByName(String name);
	
	Set<Ingredient> getIngredientByRecipeId(int recipeId);
	
	public Ingredient createIngredient(String username, Ingredient ingredient);

	public Ingredient updateIngredient(String username, int ingredientId, Ingredient ingredient);

	public boolean deleteIngredient(String username, int ingredientId);
	
	List<Ingredient> index();


	
}
