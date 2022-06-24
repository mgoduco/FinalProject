package com.skilldistillery.refresh.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.refresh.entities.Ingredient;

public interface IngredientRepository extends JpaRepository<Ingredient, Integer> {

	Ingredient findIngredientById(int ingredientId);
	
	Ingredient findByName(String ingredientName);
	
	Set<Ingredient> findByRecipeIngredients_RecipeId(int recipeId);
	
	Ingredient queryById(int ingredientId);
	
}