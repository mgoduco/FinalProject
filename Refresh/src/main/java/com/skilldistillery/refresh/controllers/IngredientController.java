package com.skilldistillery.refresh.controllers;

import java.security.Principal;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.refresh.entities.Ingredient;
import com.skilldistillery.refresh.services.IngredientService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4200" })
public class IngredientController {

	@Autowired
	  private IngredientService ingredientService;
	
	@GetMapping("i/{id}")
	public Ingredient getIngredientById(@PathVariable int id, HttpServletResponse res, Principal principal) {
		Ingredient ingredient = ingredientService.getIngredientById(id);
		if(ingredient == null) {
			res.setStatus(404);
		}
		return ingredient;
	}
	
	@GetMapping("i/search/{name}")
	public Ingredient getIngredientByName(@PathVariable String name, HttpServletResponse res, Principal principal) {
		Ingredient ingredient = ingredientService.getIngredientByName(name);
		if(ingredient == null) {
			res.setStatus(404);
		}
		return ingredient;
	}
	
	@GetMapping("i/recipe/{recipeId}")
	public Set<Ingredient> getIngredientByRecipeId(@PathVariable int recipeId, HttpServletResponse res, Principal principal) {
		Set<Ingredient> ingredients = ingredientService.getIngredientByRecipeId(recipeId);
		return ingredients; 
	}
	
	
	
	
	
	
}
