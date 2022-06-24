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

//	@Override
//	public Comment getCommentByRecipeAndUsername(int recipeId, String username) {
//		return commentRepo.findByRecipe_IdAndUser_Username(recipeId, username);
//	}

	@Override
	public Comment getCommentByIdAndRecipeId(int cid, int recipeId) {
		return commentRepo.findByIdAndRecipe_Id(cid, recipeId);
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
			System.out.println("===================================");
			System.out.println(comment.isActive());
			System.out.println("===================================");
			
			commentRepo.saveAndFlush(comment);
			return true;
		}
		return false;
	}

	// TODO COMMENTREPO FOR REPLY FINDBYCOMMENTANDUSER?
	@Override
	public Comment createReply(int cid, int rid, Comment reply, String username) {
		Comment original = commentRepo.findByIdAndRecipe_Id(cid, rid);
		if (original != null) {
			reply.setRecipe(original.getRecipe());
			reply.setUser(userRepo.findByUsername(username));
			reply.setInReplyTo(original);
			return commentRepo.saveAndFlush(reply);
		}
		return null;
	}

	@Override
	public Comment updateReply(int id, Comment comment, String username) {
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

	@Override
	public List<Comment> getCommentsByUserName(String username) {
		return commentRepo.findByUser_Username(username);
	}

}
