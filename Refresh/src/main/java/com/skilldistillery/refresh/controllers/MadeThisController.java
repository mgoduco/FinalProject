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

import com.skilldistillery.refresh.entities.MadeThis;
import com.skilldistillery.refresh.entities.User;
import com.skilldistillery.refresh.services.MadeThisService;
import com.skilldistillery.refresh.services.UserService;

//THIS NEEDS TA ADVICE BEFORE CONTINUING WITH COMPOUND-KEY TABLE

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4200" })
public class MadeThisController {

	@Autowired
	private MadeThisService madeThisService;

	@Autowired
	private UserService userService;

	@GetMapping("u/{uid}/madethis")
	public List<MadeThis> getRecipesMadeForUser(HttpServletResponse res, @PathVariable int uid) {
		List<MadeThis> madeRecipes = madeThisService.getMadeThisByUserId(uid);
		if (madeRecipes == null) {
			res.setStatus(404);
		}
		return madeRecipes;
	}

	@GetMapping("recipes/{rid}/madethis")
	public List<MadeThis> getMakersForRecipe(HttpServletResponse res, @PathVariable int rid) {
		List<MadeThis> madeRecipes = madeThisService.getMadeThisByRecipeId(rid);
		if (madeRecipes == null) {
			res.setStatus(404);
		}
		return madeRecipes;
	}

	@GetMapping("recipes/rating/{rating}")
	public List<MadeThis> getMadeRecipesForRating(HttpServletResponse res, @PathVariable int rating) {
		List<MadeThis> madeRecipes = madeThisService.getMadeThisByRating(rating);
		if (madeRecipes == null) {
			res.setStatus(404);
		}
		return madeRecipes;
	}

	@PostMapping("recipes/{rid}/madethis")
	public MadeThis create(HttpServletRequest req, HttpServletResponse res, Principal principal, @PathVariable int rid,
			@RequestBody MadeThis madeThis) {
		User user = userService.getUserByUsername(principal.getName());
		madeThis = madeThisService.createMadeThis(principal.getName(), user.getId(), rid, madeThis);
		if (madeThis == null) {
			res.setStatus(404);
		} else {
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			res.setHeader("Location", url.toString());
		}
		return madeThis;

	}

//	@PutMapping("recipes/{rid}/madethis/{mid}")
//	public MadeThis update(HttpServletRequest req, HttpServletResponse res, @PathVariable int rid,
//			@PathVariable int mid, @RequestBody MadeThis madeThis, Principal principal) {
//		try {
//			User user = userService.getUserByUsername(principal.getName());
//			madeThis = madeThisService.editMadeThis(principal.getName(), user.getId(), rid, madeThis);
//			if (madeThis == null) {
//				res.setStatus(404);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//			res.setStatus(400);
//			madeThis = null;
//		}
//		return madeThis;
//	}

	@DeleteMapping("recipes/{rid}/madethis/")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int rid, Principal principal) {
		try {
			User user = userService.getUserByUsername(principal.getName());
			if (madeThisService.deleteMadeThis(principal.getName(), user.getId(), rid)) {
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
