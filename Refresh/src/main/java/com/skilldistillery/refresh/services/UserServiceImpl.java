package com.skilldistillery.refresh.services;

import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.User;
import com.skilldistillery.refresh.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private AuthService auth;

	@Autowired
	private PasswordEncoder encoder;

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

	@Override
	public User updateUser(String username, int userId, User user) {
		User editUser = userRepo.findUserById(userId);
		if (editUser != null) {
			if (user.getPassword().length() < 40) {
				if (!encoder.matches(user.getPassword(), editUser.getPassword())) {
					editUser.setPassword(encoder.encode(user.getPassword()));
				}
			}
			editUser.setUsername(user.getUsername());
			editUser.setEmail(user.getEmail());
			editUser.setRole(user.getRole());
			editUser.setUpdated(user.getUpdated());
			editUser.setCreated(user.getCreated());
			editUser.setImageUrl(user.getImageUrl());
			editUser.setFirstname(user.getFirstname());
			editUser.setLastname(user.getLastname());
			editUser.setBiography(user.getBiography());

			userRepo.saveAndFlush(editUser);
			return editUser;
		}
		return null;
	}
	
	@Override
	public boolean deleteUser(String username, int id) {
		boolean deleted = false;
		User user = userRepo.findUserById(id);
		if(user !=null) {
			System.out.println(user.isEnabled());
		user.setEnabled(false);
		userRepo.saveAndFlush(user);
		deleted = true;
		}
		System.out.println(user.isEnabled());
		System.out.println(deleted);
		return deleted;
	}
}
