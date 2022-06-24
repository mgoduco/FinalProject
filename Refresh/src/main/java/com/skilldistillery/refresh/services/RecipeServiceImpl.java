package com.skilldistillery.refresh.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.Recipe;
import com.skilldistillery.refresh.entities.User;
import com.skilldistillery.refresh.repositories.RecipeRepository;
import com.skilldistillery.refresh.repositories.UserRepository;

@Service
public class RecipeServiceImpl implements RecipeService {

	@Autowired
	private RecipeRepository recipeRepo;
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public List<Recipe> index() {
		return recipeRepo.findAll();
	}
	
	@Override
	public List<Recipe> getRecipesByUser(String username) {
		return recipeRepo.findByUser_Username(username);
	}

	@Override
	public Recipe show(String username, int recipeId) {
		return recipeRepo.findByIdAndUser_Username(recipeId, username);
	}

	@Override
	public Recipe create(String username, Recipe recipe) {
		User user = userRepo.findByUsername(username);
		if (user != null) {
			recipe.setUser(user);
			return recipeRepo.saveAndFlush(recipe);
		}
		return null;
	}

	@Override
	public Recipe update(String username, Recipe recipe, int recipeId) {
		Recipe existing = recipeRepo.findByIdAndUser_Username(recipeId, username);
		if (existing != null) {
			existing.setName(recipe.getName());
			existing.setDescription(recipe.getDescription());
			existing.setDirections(recipe.getDirections());
//			existing.setCreated(recipe.getCreated());
//			existing.setUpdated(recipe.getUpdated());
			existing.setActive(recipe.isActive());
			existing.setPrepminutes(recipe.getPrepminutes());
			existing.setCookminutes(recipe.getCookminutes());
			existing.setImageUrl(recipe.getImageUrl());
			//TODO Add other stuff?
			
			return recipeRepo.saveAndFlush(existing);
		}
		return null;
	}

	@Override
	public boolean delete(String username, int recipeId) {
		boolean deleted = false;
		Recipe existing = recipeRepo.findByIdAndUser_Username(recipeId, username);
		if (existing != null) {
			recipeRepo.delete(existing);
			deleted = true;
			return deleted;
		}
		return false;
	}

	@Override
	public Recipe getRecipeById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Recipe> getRecipeByIngredients() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Recipe> getRecipeByKeyword() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Recipe> getRecipeBySomething() {
		// TODO Auto-generated method stub
		return null;
	}


}
