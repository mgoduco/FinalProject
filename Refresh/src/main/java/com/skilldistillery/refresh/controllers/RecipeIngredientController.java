package com.skilldistillery.refresh.controllers;

import java.security.Principal;
import java.util.List;

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

	@GetMapping("recipes/{rid}/ingredients/{iid}")
	public RecipeIngredient getIngredientForRecipe(HttpServletResponse res, @PathVariable int rid, @PathVariable int iid) {
		RecipeIngredient recipeIngredient = recipeIngredientService.getByRecipeIdAndIngredientId(rid, iid);
		if (recipeIngredient == null) {
			res.setStatus(404);
		}
		return recipeIngredient;
	}
	
	@PostMapping("recipes/{rid}/ingredients/{iid}")
	public RecipeIngredient create(HttpServletRequest req, HttpServletResponse res, @RequestBody RecipeIngredient recipeIngredient,
			Principal principal, @PathVariable int rid, @PathVariable int iid) {
		recipeIngredient = recipeIngredientService.createForRecipe(principal.getName(), rid, iid, recipeIngredient);
		if (recipeIngredient == null) {
			res.setStatus(404);
		} else {
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			res.setHeader("Location", url.toString());
		}
		return recipeIngredient;

	}

//  PUT todos/{tid}
	@PutMapping("recipes/{rid}/ingredients/{iid}")
	public RecipeIngredient update(HttpServletRequest req, HttpServletResponse res, @RequestBody RecipeIngredient recipeIngredient, Principal principal,
			@PathVariable int rid, @PathVariable int iid) {
		try {
			recipeIngredient = recipeIngredientService.editRecipeIngredient(principal.getName(), iid, rid, recipeIngredient);
			if (recipeIngredient == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			recipeIngredient = null;
		}
		return recipeIngredient;
	}
	
	@DeleteMapping("recipes/{rid}/ingredients/{iid}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int rid, @PathVariable int iid, Principal principal) {
		try {
			if (recipeIngredientService.deleteRecipeIngredient(principal.getName(), rid, iid)) {
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
