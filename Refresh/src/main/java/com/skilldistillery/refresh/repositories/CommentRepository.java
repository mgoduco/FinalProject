package com.skilldistillery.refresh.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.refresh.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

	Comment queryById(int id);
	
	List<Comment> findByUser_Id(int userId);
	
//	Comment findByInReplyTo(String comment, int id);
	
	List<Comment> findByRecipe_Id(int recipeId);

	List<Comment> queryByRecipe_Id(int recipeId);
	
	List<Comment> findByUser_Username(String username);
	
	Comment findByRecipe_IdAndUser_Username(int recipedId, String username);
	
	Comment findByIdAndRecipe_Id(int cid, int recipedId);
	
//	Comment findByRecipe_IdAndUser_Id(int recipedId, int userId);

}
