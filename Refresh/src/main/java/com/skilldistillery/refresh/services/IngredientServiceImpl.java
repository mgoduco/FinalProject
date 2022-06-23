package com.skilldistillery.refresh.services;

import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.Ingredient;
import com.skilldistillery.refresh.repositories.IngredientRepository;
import com.skilldistillery.refresh.repositories.RecipeRepository;

@Service
public class IngredientServiceImpl implements IngredientService {

	@Autowired
	private IngredientRepository ingredientRepo;
	@Autowired
	private RecipeRepository recipeRepo;

	@Override
	public Ingredient getIngredientById(int id) {
		Optional<Ingredient> optIngredient = ingredientRepo.findById(id);
		Ingredient ingredient = null;
		if (optIngredient.isPresent()) {
			ingredient = optIngredient.get();
		}
		return ingredient;
	}

	@Override
	public Ingredient getIngredientByName(String name) {
		Ingredient optIngredient = ingredientRepo.findByName(name);
		Ingredient ingredient = null;
		if (optIngredient != null) {
			ingredient = optIngredient;
		}
		return ingredient;
	}

	@Override
	public Set<Ingredient> getIngredientByRecipeId(int recipeId) {
		Set<Ingredient> ingredients = ingredientRepo.findByRecipeIngredients_RecipeId(recipeId);
		return ingredients;
	}

	@Override
	public Ingredient createIngredient(String name, Ingredient ingredient) {
		if (ingredientRepo.findByName(ingredient.getName()) != null) {
			
		}
		return null;
	}

//	@Override
//	public Todo create(String username, Todo todo) {
//		User user = userRepo.findByUsername(username);
//		if (user != null) {
//			todo.setUser(user);
//			return todoRepo.saveAndFlush(todo);
//		}
//		return null;
//	}

	@Override
	public Ingredient updateIngredient(String username, int ingredientId, Ingredient ingredient) {
		Ingredient existing = ingredientRepo.findIngredientById(ingredientId);
		if (existing != null) {
			existing.setName(ingredient.getName());
			existing.setDescription(ingredient.getDescription());
			existing.setImageUrl(ingredient.getImageUrl());
			existing.setKcals(ingredient.getKcals());
			ingredientRepo.saveAndFlush(existing);
			return existing;
		}
		return null;
	}

	// TODO: THIS METHOD MAY REQUIRE THAT THE INGREDIENT BE SET TO 'ACTIVE = 0'
	// INSTEAD OF DELETED
	@Override
	public boolean deleteIngredient(String username, int ingredientId) {
		boolean deleted = false;
		Ingredient toDelete = ingredientRepo.findIngredientById(ingredientId);
		if (toDelete != null) {
			ingredientRepo.delete(toDelete);
			deleted = true;
		}
		return deleted;
	}

}
