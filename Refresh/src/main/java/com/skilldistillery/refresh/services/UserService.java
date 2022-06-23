package com.skilldistillery.refresh.services;

import com.skilldistillery.refresh.entities.User;

public interface UserService {
	User getUserById(int userId);

	User getUserByUsername(String username);
}
