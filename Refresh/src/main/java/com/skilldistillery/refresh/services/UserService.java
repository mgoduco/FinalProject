package com.skilldistillery.refresh.services;

import com.skilldistillery.refresh.entities.User;

public interface UserService {
	User getUserById(int userId);

	User getUserByUsername(String username);

	User updateUser(String username, int userId, User user);
}
