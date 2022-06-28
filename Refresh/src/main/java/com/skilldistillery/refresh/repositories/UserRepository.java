package com.skilldistillery.refresh.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.refresh.entities.Recipe;
import com.skilldistillery.refresh.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	User findUserById(int userId);

	User findByUsername(String username);
	
	List<Recipe> findFavoriteRecipesById(int userId);
	
	
}
