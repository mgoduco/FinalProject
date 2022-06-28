package com.skilldistillery.refresh.services;

import java.util.List;

import com.skilldistillery.refresh.entities.Recipe;
import com.skilldistillery.refresh.entities.User;

public interface UserService {
	User getUserById(int userId);

	User getUserByUsername(String username);

	User updateUser(String username, int userId, User user);

	boolean deleteUser(String username, int id);
	
	List<Recipe> getFavoritesById (int userId);
	
	boolean setFavorite(int userId, int recipeId);
}
