package com.skilldistillery.refresh.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.refresh.entities.Recipe;

public interface RecipeRepository extends JpaRepository<Recipe, Integer> {

	List<Recipe> findByUser_Username(String username);

	Recipe findByIdAndUser_Username(String username, int recipeId);

	Recipe findByid(int id);

	List<Recipe> findByName(@Param("keyword") String keyword);

	List<Recipe> findRecipeByRecipeIngredients(@Param("keyword") String keyword);
	
	List<Recipe> findRecipeByUserFavorites(String username);
	
	
}
