package com.skilldistillery.refresh.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.MadeThis;
import com.skilldistillery.refresh.entities.MadeThisId;
import com.skilldistillery.refresh.entities.Recipe;
import com.skilldistillery.refresh.entities.User;
import com.skilldistillery.refresh.repositories.MadeThisRepository;
import com.skilldistillery.refresh.repositories.RecipeRepository;
import com.skilldistillery.refresh.repositories.UserRepository;

@Service
public class MadeThisServiceImpl implements MadeThisService {

	@Autowired
	private MadeThisRepository madeThisRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private RecipeRepository recipeRepo;

	@Override
	public List<MadeThis> getMadeThisByUserId(int userId) {
		return madeThisRepo.findByUser_Id(userId);
	}

	@Override
	public List<MadeThis> getMadeThisByUsername(String username) {
		return madeThisRepo.findByUser_Username(username);
	}

	@Override
	public List<MadeThis> getMadeThisByRecipeId(int recipeId) {
		return madeThisRepo.findByRecipe_Id(recipeId);
	}

	@Override
	public MadeThis getMadeThisByRecipeAndUserIds(int userId, int recipeId) {
		return madeThisRepo.findByRecipe_IdAndUser_Id(userId, recipeId);
	}

	@Override
	public List<MadeThis> getMadeThisByRating(int rating) {
		return madeThisRepo.findByRatingBetween(rating, 5);
	}

	@Override
	public MadeThis createMadeThis(String username, int userId, int recipeId, MadeThis madeThis) {
		User user = userRepo.findUserById(userId);
		Recipe recipe = recipeRepo.queryById(recipeId);
		if (user != null && recipe != null) {
			MadeThisId madeThisId = new MadeThisId(userId, recipeId);
			madeThis.setId(madeThisId);
			madeThis.setUser(user);
			madeThis.setRecipe(recipe);
			madeThisRepo.saveAndFlush(madeThis);
			return madeThis;
		}
		return null;
	}

	@Override
	public MadeThis editMadeThis(String username, int userId, int recipeId, MadeThis madeThis) {
		MadeThis editMadeThis = madeThisRepo.findByRecipe_IdAndUser_Id(recipeId, userId);
		if (editMadeThis != null) {
			editMadeThis.setRating(madeThis.getRating());
			editMadeThis.setComment(madeThis.getComment());
			editMadeThis.setImageUrl(madeThis.getImageUrl());
			madeThisRepo.saveAndFlush(editMadeThis);
		}
		return null;
	}

	@Override
	public boolean deleteMadeThis(String username, int userId, int recipeId) {
		boolean deleted = false;
		MadeThis toDelete = madeThisRepo.findByRecipe_IdAndUser_Id(recipeId, userId);
		if (toDelete != null) {
			madeThisRepo.delete(toDelete);
			deleted = true;
		}
		return deleted;
	}

}
