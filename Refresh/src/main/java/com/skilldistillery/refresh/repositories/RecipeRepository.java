package com.skilldistillery.refresh.repositories;

import java.util.List;

// THIS NEEDS TA ADVICE BEFORE CONTINUING WITH COMPOUND-KEY TABLE

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.refresh.entities.Ingredient;
import com.skilldistillery.refresh.entities.Recipe;

public interface RecipeRepository extends JpaRepository<Recipe, Integer> {

	Recipe findByRecipe_Id(int recipeId);
	Recipe findByRecipe_Name(String recipeName);

	Ingredient findByIngredient_Id(int ingredientId);
	Ingredient findByIngredient_Name(String ingredientName);

	Recipe findByIdAndUser_Username(int recipeId, String username);

	Recipe findByid(int id);

	List<Recipe> findByName(@Param("keyword") String keyword);

	List<Recipe> findRecipeByRecipeIngredients(@Param("keyword") String keyword);
	
	List<Recipe> findRecipeByUserFavorites(String username);
	
	
}
