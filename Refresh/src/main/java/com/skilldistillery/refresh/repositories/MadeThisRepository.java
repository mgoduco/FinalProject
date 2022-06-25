package com.skilldistillery.refresh.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.refresh.entities.MadeThis;
import com.skilldistillery.refresh.entities.RecipeIngredient;

public interface MadeThisRepository extends JpaRepository<MadeThis, Integer> {

	List<MadeThis> findByUser_Username(String username);
	
	List<MadeThis> findByUser_Id(int userId);
	
	List<MadeThis> findByRecipe_Id(int recipeId);

	MadeThis findByRecipe_IdAndUser_Id (int recipeId, int userId);
	
	List<MadeThis> findByRatingBetween(int ratingLow, int ratingHigh);
	
	
}
