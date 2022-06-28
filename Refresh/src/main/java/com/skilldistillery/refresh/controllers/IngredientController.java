package com.skilldistillery.refresh.controllers;

import java.security.Principal;
import java.util.List;
import java.util.Set;

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

import com.skilldistillery.refresh.entities.Ingredient;
import com.skilldistillery.refresh.services.IngredientService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4200" })
public class IngredientController {

	@Autowired
	private IngredientService ingredientService;

	@GetMapping("i/index")
	public List<Ingredient> index(HttpServletResponse res) {
		List<Ingredient> ingredients = ingredientService.index();
		return ingredients;
	}

	@GetMapping("i/{id}")
	public Ingredient getIngredientById(@PathVariable int id, HttpServletResponse res, Principal principal) {
		Ingredient ingredient = ingredientService.getIngredientById(id);
		if (ingredient == null) {
			res.setStatus(404);
		}
		return ingredient;
	}

	@GetMapping("i/search/{name}")
	public Ingredient getIngredientByName(@PathVariable String name, HttpServletResponse res, Principal principal) {
		Ingredient ingredient = ingredientService.getIngredientByName(name);
		if (ingredient == null) {
			res.setStatus(404);
		}
		return ingredient;
	}

	@GetMapping("i/recipe/{recipeId}")
	public Set<Ingredient> getIngredientByRecipeId(@PathVariable int recipeId, HttpServletResponse res,
			Principal principal) {
		Set<Ingredient> ingredients = ingredientService.getIngredientByRecipeId(recipeId);
		return ingredients;
	}

	@PostMapping("i")
	public Ingredient create(HttpServletRequest req, HttpServletResponse res, @RequestBody Ingredient ingredient,
			Principal principal) {
		try {
			ingredient = ingredientService.createIngredient(principal.getName(), ingredient);
			if (ingredient == null) {
				res.setStatus(404);
			} else {
				res.setStatus(201);
				StringBuffer url = req.getRequestURL();
				url.append("/").append(ingredient.getId());
				res.setHeader("Location", url.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("Invalid Ingredient JSON");
			res.setStatus(400);
			ingredient = null;
		}
		return ingredient;
	}

	@PutMapping("i/{ingredientId}")
	public Ingredient update(HttpServletRequest req, HttpServletResponse res, @PathVariable int ingredientId,
			@RequestBody Ingredient ingredient, Principal principal) {
		try {
			ingredient = ingredientService.updateIngredient(principal.getName(), ingredientId, ingredient);
			if (ingredient == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			ingredient = null;
		}
		return ingredient;
	}

	@DeleteMapping("i/{ingredientId}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int ingredientId,
			Principal principal) {
		try {
			if (ingredientService.deleteIngredient(principal.getName(), ingredientId)) {
				res.setStatus(204);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
	}

}
