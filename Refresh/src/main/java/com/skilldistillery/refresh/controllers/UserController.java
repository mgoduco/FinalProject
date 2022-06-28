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

import com.skilldistillery.refresh.entities.Recipe;
import com.skilldistillery.refresh.entities.User;
import com.skilldistillery.refresh.repositories.UserRepository;
import com.skilldistillery.refresh.services.RecipeService;
import com.skilldistillery.refresh.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4200" })
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private RecipeService recipeService;

	@Autowired
	private UserRepository userRepo;

	// SMOKE TEST ONLY, DELETE/COMMENT OUT LATER
//	@GetMapping("test/users/{userId}")
//	public User getUserForTest(
//	  @PathVariable Integer userId,
//	  HttpServletResponse res
//	) {
//	  User user = userService.getUserById(userId);
//	  if (user == null) {
//	    res.setStatus(404);
//	  }
//	  return user;
//	}

	@GetMapping("u/{id}")
	public User getUserById(@PathVariable int id, HttpServletResponse res) {
		User user = userService.getUserById(id);
		if (user == null) {
			res.setStatus(404);
		}
		return user;
	}

	@GetMapping("u/{id}/favorites")
	public List<Recipe> getFavorites(@PathVariable int id, HttpServletResponse res, Principal principal) {
		User user = userService.getUserByUsername(principal.getName());
		List<Recipe> favorites = null;
		if (user == null) {
			res.setStatus(404);
		} else {
			favorites = userService.getFavoritesById(user.getId());
		}
		return favorites;
	}
	
	@GetMapping("u/favorites/{rid}")
	public boolean getFavorite(HttpServletRequest req, HttpServletResponse res, Principal principal, @PathVariable int rid) {
		boolean favorite = false;
		User user = userService.getUserByUsername(principal.getName());
		Recipe recipe = recipeService.getRecipeById(rid);
		if (user != null && recipe != null) {
			Recipe favRecipe = recipeService.getFavoriteRecipeByUsernameAndId(principal.getName(), rid);
			if (favRecipe != null) {
				favorite = true;
				res.setStatus(200);
			}
			else {
				res.setStatus(404);
			}
		}
		return favorite;
	}

	@PostMapping("u/{uid}/favorites/{rid}")
	public boolean addFavorite(HttpServletRequest req, HttpServletResponse res, Principal principal,
			@PathVariable int uid, @PathVariable int rid) {
		System.out.println("User ID: " + uid);
		System.out.println("Recipe ID: " + rid);
		boolean favorite = false;
		User user = userService.getUserByUsername(principal.getName());
		System.out.println(user);
		Recipe recipe = recipeService.getRecipeById(rid);
		System.out.println(recipe);
		if (user.getId() == uid && recipe != null) {
			favorite = userService.setFavorite(uid, rid);
			res.setStatus(200);
		} else {
			res.setStatus(404);
		}
		return favorite;
	}

	@PutMapping("u/{id}")
	public User update(@RequestBody User user, @PathVariable int id, HttpServletRequest req, HttpServletResponse res,
			Principal principal) {
		try {
			user = userService.updateUser(principal.getName(), id, user);
			if (user == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			user = null;
		}
		return user;
	}

	@DeleteMapping("u/{id}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int id, Principal principal) {
		try {
			if (userService.deleteUser(principal.getName(), id)) {
				res.setStatus(204);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
	}
	
	@DeleteMapping("u/{uid}/favorites/{rid}")
	public void removeFavorite(HttpServletRequest req, HttpServletResponse res, @PathVariable int uid, @PathVariable int rid, Principal principal) {
		try {
			User user = userService.getUserByUsername(principal.getName());
			if (userService.removeFavorite(user.getId(),rid)) {
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
