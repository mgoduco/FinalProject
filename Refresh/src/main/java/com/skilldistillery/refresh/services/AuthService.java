package com.skilldistillery.refresh.services;

import com.skilldistillery.refresh.entities.User;

public interface AuthService {
	
	public User register(User user);
	public User getUserByUsername(String username);


}
