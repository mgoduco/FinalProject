package com.skilldistillery.refresh.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.User;
import com.skilldistillery.refresh.repositories.KeywordRepository;

@Service
public class KeywordServiceImpl implements UserService {

	@Autowired
	private KeywordRepository keywordRepo;

	@Override
	public User getUserById(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User getUserByUsername(String username) {
		// TODO Auto-generated method stub
		return null;
	}



}
