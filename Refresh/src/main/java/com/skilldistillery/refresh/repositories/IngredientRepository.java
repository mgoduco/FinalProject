package com.skilldistillery.refresh.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.refresh.entities.Ingredient;

public interface IngredientRepository extends JpaRepository<Ingredient, Integer> {

	Ingredient findIngredientById(int ingredientId);
	
	Ingredient findByName(String ingredientName);
	
	Set<Ingredient> findByRecipeIngredients_RecipeId(int recipeId);
	
}

//* INGREDIENT: Find ingredient by ID
//* INGREDIENT: Find ALL ingredients by Recipe ID
//* INGREDIENT: Find ALL recipes by Ingredient Name
//* INGREDIENT: Create Ingredient
//* INGREDIENT: Edit Ingredient
//* INGREDIENT: Delete Ingredient 