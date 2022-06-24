package com.skilldistillery.refresh.services;

import java.util.List;

import com.skilldistillery.refresh.entities.Comment;

public interface CommentService {
	
	Comment getCommentById(int id);
	
	Comment create(int recipeId, Comment comment, String username);
	
	Comment update(int recipeId, Comment comment, String username);
	
	boolean disable(int userId, int id, String username);
	
	
	List<Comment> getByRecipe(int recipeId); 
	
	List<Comment> index();

	Comment createReply(int id, Comment inReplyTo, Comment comment, String username); 
	
}
