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
		// TODO Auto-generated method stub
		Recipe recipe = recipeRepo.findByName(name);
		if (user != null) {
			todo.setUser(user);
			return todoRepo.saveAndFlush(todo);
		}
		return null;
		return null;
	}

	@Override
	public Todo create(String username, Todo todo) {
		User user = userRepo.findByUsername(username);
		if (user != null) {
			todo.setUser(user);
			return todoRepo.saveAndFlush(todo);
		}
		return null;
	}
	
	@Override
	public Ingredient updateIngredient(String username, int ingredientId, Ingredient ingredient) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean hideIngredient(String username, int ingredientId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Todo update(String username, int tid, Todo todo) {
		Todo existing = todoRepo.findByIdAndUser_Username(tid, username);
		if (existing != null) {
			existing.setCompleted(todo.isCompleted());
			existing.setCompleteDate(todo.getCompleteDate());
			existing.setDescription(todo.getDescription());
			existing.setDueDate(todo.getDueDate());
			existing.setTask(todo.getTask());
			todoRepo.saveAndFlush(existing);
			return existing;
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		boolean deleted = false;
		Todo toDelete = todoRepo.findByIdAndUser_Username(tid, username);
		if (toDelete != null) {
			todoRepo.delete(toDelete);
			deleted = true;
		}
		return deleted;
	}

	

}
