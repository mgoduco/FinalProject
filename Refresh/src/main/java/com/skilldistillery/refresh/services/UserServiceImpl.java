package com.skilldistillery.refresh.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.User;
import com.skilldistillery.refresh.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;

	@Override
	public User getUserById(int userId) {
		Optional<User> userOpt = userRepo.findById(userId);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		return user;
	}

	@Override
	public User getUserByUsername(String username) {
		User userOpt = userRepo.findByUsername(username);
		User user = null;
		if (userOpt != null) {
			user = userOpt;
		}
		return user;
	}

}
