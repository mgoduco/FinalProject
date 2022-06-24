package com.skilldistillery.refresh.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.refresh.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

	Comment findById(int id);
	
	List<Comment> findByUser_Id(int userId);
	
	Comment findByInReplyTo(String comment, int id);
	
	List<Comment> findByRecipe_Id(int recipeId);
	
}
