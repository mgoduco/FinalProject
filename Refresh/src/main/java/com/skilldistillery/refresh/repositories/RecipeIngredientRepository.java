package com.skilldistillery.refresh.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.refresh.entities.RecipeIngredient;
import com.skilldistillery.refresh.entities.RecipeIngredientId;


//THIS NEEDS TA ADVICE BEFORE CONTINUING WITH COMPOUND-KEY TABLE

public interface RecipeIngredientRepository extends JpaRepository<RecipeIngredient, RecipeIngredientId> {

	List<RecipeIngredient> findByRecipe_User_Username(String username);

	List<RecipeIngredient> findByRecipe_Id(int recipeId);

	RecipeIngredient findByRecipe_IdAndIngredient_Id (int recipeId, int ingredientId);
	
}
