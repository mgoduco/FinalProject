package com.skilldistillery.refresh.controllers;

import java.security.Principal;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.refresh.entities.Recipe;
import com.skilldistillery.refresh.services.RecipeService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4200" })
public class RecipeController {

	@Autowired
	private RecipeService recipeService;

	@GetMapping("recipes")
	public List<Recipe> getAllRecipes(HttpServletResponse res, Principal principal) {
		List<Recipe> recipes = recipeService.index();
		if (recipes == null) {
			res.setStatus(404);
		}
		return recipes;
	}

	@GetMapping("recipes/search/{name}")
	public Set<Recipe> getRecipesByNameAndIngredient(HttpServletRequest req, HttpServletResponse res, @PathVariable String name) {
		List<Recipe> recipes = recipeService.getRecipeByNameAndIngredients(name, name);
		Set<Recipe> uniqueRecipes = recipes.stream().distinct().collect(Collectors.toSet()); 
		if (uniqueRecipes == null) {
			res.setStatus(404);
		} 
		return uniqueRecipes;
	}
	
	@GetMapping("recipes/search/name/{name}")
	public List<Recipe> getRecipesByName(HttpServletRequest req, HttpServletResponse res, @PathVariable String name) {
		List<Recipe> recipes = recipeService.getRecipeByName(name);
		if (recipes == null) {
			res.setStatus(404);
		} 
		return recipes;
	}
	
	@GetMapping("recipes/search/ingredient/{name}")
	public List<Recipe> getRecipesByIngredientName(HttpServletRequest req, HttpServletResponse res, @PathVariable String name) {
		List<Recipe> recipes = recipeService.getRecipeByIngredients(name);
		if (recipes == null) {
			res.setStatus(404);
		} 
		return recipes;
	}

	@GetMapping("recipe/{id}")
//	public Recipe show(HttpServletRequest req, HttpServletResponse res, Principal principal, @PathVariable int id) {
		public Recipe show(HttpServletRequest req, HttpServletResponse res, @PathVariable int id) {
		System.out.println("=======================================================");
//		System.out.println(principal.getName());
		System.out.println("=======================================================");
//		Recipe recipe = recipeService.show(principal.getName(), id);
		Recipe recipe = recipeService.show(id);
		if (recipe == null) {
			res.setStatus(404);
		}
		return recipe;
	}

	@GetMapping("recipes/u/{username}")
	public List<Recipe> index(@PathVariable String username, HttpServletResponse res, Principal principal) {
		List<Recipe> recipes = recipeService.getRecipesByUser(username);
		if (recipes == null) {
			res.setStatus(404);
		}
		return recipes;
	}

	@PostMapping("recipes")
	public Recipe create(HttpServletRequest req, HttpServletResponse res, @RequestBody Recipe recipe,
			Principal principal) {
		recipe = recipeService.create(principal.getName(), recipe);
		if (recipe == null) {
			res.setStatus(404);
		} else {
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(recipe.getId());
			res.setHeader("Location", url.toString());
		}
		return recipe;

	}

	@PutMapping("recipes/{id}")
	public Recipe update(HttpServletRequest req, HttpServletResponse res, @PathVariable int id,
			@RequestBody Recipe recipe, Principal principal) {
		try {
			recipeService.update(principal.getName(), recipe, id);
			res.setStatus(200);
			if (recipe == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			recipe = null;
		}
		return recipe;
	}

	@DeleteMapping("recipes/{id}")
	public void delete(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		if (recipeService.delete(principal.getName(), id)) {
			res.setStatus(200);
		} else {
			res.setStatus(404);
		}
	}

}
