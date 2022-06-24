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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.refresh.entities.Comment;
import com.skilldistillery.refresh.entities.Recipe;
import com.skilldistillery.refresh.services.CommentService;
import com.skilldistillery.refresh.services.RecipeService;
import com.skilldistillery.refresh.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4200" })
public class CommentController {

	@Autowired
	private CommentService commentService;
	@Autowired
	private RecipeService recipeService;
	@Autowired
	private UserService userService;

	//TODO THIS DOESNT WORK ??????
	@GetMapping("comments")
	public List<Comment> getByRecipe(HttpServletResponse res, Principal principal, int recipeId) {
		List<Comment> comments = commentService.getByRecipe(recipeId);
		if (comments == null) {
			res.setStatus(404);
		}
		return comments;
	}

	@GetMapping("comment/{id}")
	public Comment show(HttpServletRequest req, HttpServletResponse res, Principal principal, @PathVariable int id) {
		Comment comment = commentService.getCommentById(id);
		if (comment == null) {
			res.setStatus(404);
		}
		return comment;
	}

	@PostMapping("recipes/{id}/comments")
	public Comment create(HttpServletRequest req, HttpServletResponse res, @RequestBody Comment comment,
			Principal principal, @PathVariable int id) {
		Recipe recipe = recipeService.getRecipeById(id);
		comment = commentService.create(id, comment, principal.getName());
		if (recipe == null) {
			res.setStatus(404);
		} else {
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(comment.getId());
			res.setHeader("Location", url.toString());
		}
		return comment;

	}

	@PutMapping("recipes/{rid}/comments/{id}")
	public Comment update(HttpServletRequest req, HttpServletResponse res, @PathVariable int rid, @PathVariable int id,
			@RequestBody Comment comment, Principal principal) {
		try {
			commentService.update(id, comment, principal.getName());
			res.setStatus(200);
			if (comment == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			comment = null;
		}
		return comment;
	}

}
