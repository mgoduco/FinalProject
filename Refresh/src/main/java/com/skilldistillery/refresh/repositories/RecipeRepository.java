package com.skilldistillery.refresh.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.refresh.entities.Recipe;

public interface RecipeRepository extends JpaRepository<Recipe, Integer> {

	List<Recipe> findByUser_Username(String username);

	Recipe findByIdAndUser_Username(int recipeId, String username);

	Recipe findById(int id);
	
	//TODO List<Recipe> findByKeyword();
	
//	@Query("select r from Recipe r where r.recipeName like %:name%")
	List<Recipe> findByNameLike(@Param("keyword")String name);
	
	List<Recipe> findRecipeByUserFavorites(String username);
	
	Recipe queryById(int recipeId);
	
	List<Recipe> findByRecipeIngredients_Ingredient_NameLike(String ingredient);

}
