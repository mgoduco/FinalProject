package com.skilldistillery.refresh.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.refresh.entities.RecipeIngredient;
import com.skilldistillery.refresh.services.RecipeIngredientService;

//THIS NEEDS TA ADVICE BEFORE CONTINUING WITH COMPOUND-KEY TABLE


@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4200" })
public class RecipeIngredientController {

	@Autowired
	private RecipeIngredientService recipeIngredientService;

	@GetMapping("recipes/{rid}")
	public List<RecipeIngredient> getForRecipe(HttpServletResponse res, @PathVariable int rid) {
		List<RecipeIngredient> recipeIngredients = recipeIngredientService.getRecipeIngredients(rid);
		if (recipeIngredients == null) {
			res.setStatus(404);
		}
		return recipeIngredients;
	}

	@GetMapping("recipes/{rid}/ingredients/{ingredientId}")
	public RecipeIngredient getIngredientForRecipe(HttpServletResponse res, @PathVariable int rid, @PathVariable int ingredientId) {
		RecipeIngredient recipeIngredient = recipeIngredientService.getByRecipeIdAndIngredientId(rid, ingredientId);
		if (recipeIngredient == null) {
			res.setStatus(404);
		}
		return recipeIngredient;
	}
	
	@PostMapping("recipes/{rid}/ingredients/{ingredientId}")
	public RecipeIngredient create(HttpServletRequest req, HttpServletResponse res, @RequestBody RecipeIngredient recipeIngredient,
			Principal principal, @PathVariable int rid, @PathVariable int ingredientId) {
		recipeIngredient = recipeIngredientService.createForRecipe(principal.getName(), rid, ingredientId, recipeIngredient);
		if (recipeIngredient == null) {
			res.setStatus(404);
		} else {
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			res.setHeader("Location", url.toString());
		}
		return recipeIngredient;

	}

}
