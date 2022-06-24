package com.skilldistillery.refresh.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.refresh.entities.User;
import com.skilldistillery.refresh.repositories.UserRepository;
import com.skilldistillery.refresh.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4200" })
public class UserController {

	@Autowired
	  private UserService userService;
	
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
		if(user == null) {
			res.setStatus(404);
		}
		return user;
	}
	
	@PutMapping("u/{id}")
	public User update(@RequestBody User user, @PathVariable int id, HttpServletRequest req, 
			HttpServletResponse res, Principal principal) {
		try {
			user = userService.updateUser(principal.getName(), id, user);
			if(user == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			user = null;
		}
		return user;
	}
	
//	@PutMapping("i/{ingredientId}")
//	public Ingredient update(HttpServletRequest req, HttpServletResponse res, @PathVariable int ingredientId,
//			@RequestBody Ingredient ingredient, Principal principal) {
//		try {
//			ingredient = ingredientService.updateIngredient(principal.getName(), ingredientId, ingredient);
//			if (ingredient == null) {
//				res.setStatus(404);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			res.setStatus(400);
//			ingredient = null;
//		}
//		return ingredient;
//	}
	
	
	
}
