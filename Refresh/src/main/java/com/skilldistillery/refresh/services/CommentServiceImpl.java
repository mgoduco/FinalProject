package com.skilldistillery.refresh.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.Comment;
import com.skilldistillery.refresh.entities.Recipe;
import com.skilldistillery.refresh.entities.User;
import com.skilldistillery.refresh.repositories.CommentRepository;
import com.skilldistillery.refresh.repositories.RecipeRepository;
import com.skilldistillery.refresh.repositories.UserRepository;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentRepository commentRepo;

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private RecipeRepository recipeRepo;

	@Override
	public Comment getCommentById(int id) {
		return commentRepo.queryById(id);
	}

	@Override
	public Comment create(int recipeId, Comment comment, String username) {
		Recipe recipe = recipeRepo.queryById(recipeId);
		User user = userRepo.findByUsername(username);
		if (recipe != null && user != null) {
			comment.setRecipe(recipe);
			comment.setUser(user);
			return commentRepo.saveAndFlush(comment);

		}
		return null;
	}

	@Override
	public Comment update(int id, Comment comment, String username) {
		Comment existing = commentRepo.queryById(id);
		if (existing != null) {
			existing.setTitle(comment.getTitle());
			existing.setComment(comment.getComment());
			existing.setActive(comment.isActive());
			return commentRepo.saveAndFlush(existing);
		}
		return null;
	}

	@Override
	public boolean disable(int userId, int id, String username) {
		Comment comment = commentRepo.queryById(id);
		if (comment != null) {
			comment.setActive(false);
			commentRepo.saveAndFlush(comment);
			return true;
		}
		return false;
	}

	@Override
	public Comment createReply(int id, Comment inReplyTo, Comment comment, String username) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Comment> getByRecipe(int recipeId) {
		List<Comment> comments = commentRepo.findByRecipe_Id(recipeId);
		System.out.println("=======================================================");
		System.out.println(comments);
		System.out.println("=======================================================");
		return comments;
	}

	@Override
	public List<Comment> index() {
		// TODO Auto-generated method stub
		return null;
	}

}
