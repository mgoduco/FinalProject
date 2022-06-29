package com.skilldistillery.refresh.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.Ingredient;
import com.skilldistillery.refresh.entities.Recipe;
import com.skilldistillery.refresh.entities.RecipeIngredient;
import com.skilldistillery.refresh.entities.RecipeIngredientId;
import com.skilldistillery.refresh.repositories.IngredientRepository;
import com.skilldistillery.refresh.repositories.RecipeIngredientRepository;
import com.skilldistillery.refresh.repositories.RecipeRepository;
import com.skilldistillery.refresh.repositories.UserRepository;

//THIS NEEDS TA ADVICE BEFORE CONTINUING WITH COMPOUND-KEY TABLE

@Service
public class RecipeIngredientServiceImpl implements RecipeIngredientService {

	@Autowired
	private RecipeRepository recipeRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private IngredientRepository ingredientRepo;

	@Autowired
	private RecipeIngredientRepository recipeIngredientRepo;

	@Override
	public List<RecipeIngredient> getRecipeIngredients(int recipeId) {
		if (recipeRepo.existsById(recipeId)) {
			return recipeIngredientRepo.findByRecipe_Id(recipeId);
		}
		return null;
	}

	@Override
	public RecipeIngredient getByRecipeIdAndIngredientId(int recipeId, int ingredientId) {

		return recipeIngredientRepo.findByRecipe_IdAndIngredient_Id(recipeId, ingredientId);
	}

	@Override
	public RecipeIngredient createForRecipe(String username, int recipeId, int ingredientId,
			RecipeIngredient recipeIngredient) {
		
		Recipe recipe = recipeRepo.findByIdAndUser_Username(recipeId, username);
		Ingredient ingredient = ingredientRepo.queryById(ingredientId);
		if (recipe != null && ingredient != null) {
			RecipeIngredientId recipeIngredientId = new RecipeIngredientId(ingredientId, recipeId);
			recipeIngredient.setId(recipeIngredientId);
			recipeIngredient.setRecipe(recipe);
			recipeIngredient.setIngredient(ingredient);
			System.out.println(recipeIngredient);
			recipeIngredientRepo.saveAndFlush(recipeIngredient);
			return recipeIngredient;
		}
		return null;
	}

	@Override
	public RecipeIngredient editRecipeIngredient(String username, int iid, int rid, RecipeIngredient recipeIngredient) {
		RecipeIngredient editRecipeIngredient = recipeIngredientRepo.findByRecipe_IdAndIngredient_Id(rid, iid);
		if (editRecipeIngredient != null) {
			editRecipeIngredient.setIngredient(recipeIngredient.getIngredient());
			editRecipeIngredient.setRecipe(recipeIngredient.getRecipe());
			editRecipeIngredient.setIngredient(recipeIngredient.getIngredient());
			editRecipeIngredient.setAmount(recipeIngredient.getAmount());
			editRecipeIngredient.setMeasure(recipeIngredient.getMeasure());
			editRecipeIngredient.setPreparation(recipeIngredient.getPreparation());
			recipeIngredientRepo.saveAndFlush(editRecipeIngredient);
			return editRecipeIngredient;
		}
		return null;
	}

	@Override
	public boolean deleteRecipeIngredient(String username, int rid, int iid) {
		boolean deleted = false;
		RecipeIngredient toDelete = recipeIngredientRepo.findByRecipe_IdAndIngredient_Id(rid, iid);
		if (toDelete != null) {
			recipeIngredientRepo.delete(toDelete);
			deleted = true;
		}
		return deleted;
	}

}
