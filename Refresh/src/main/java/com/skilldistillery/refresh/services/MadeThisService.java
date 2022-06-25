package com.skilldistillery.refresh.services;

import java.util.List;

import com.skilldistillery.refresh.entities.MadeThis;

public interface MadeThisService {

	List<MadeThis> getMadeThisByUserId(int userId);
	
	List<MadeThis> getMadeThisByUsername(String username);
	
	List<MadeThis> getMadeThisByRecipeId(int recipeId);
	
	MadeThis getMadeThisByRecipeAndUserIds(int userId, int recipeId);
	
	List<MadeThis> getMadeThisByRating(int rating);
	
	MadeThis createMadeThis (String username, int userId, int recipeId,
			MadeThis madeThis);
	
	MadeThis editMadeThis(String username, int userId, int recipeId, MadeThis madeThis);
	
	boolean deleteMadeThis(String username, int userId, int recipeId);


}
