package com.skilldistillery.refresh.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.Keyword;
import com.skilldistillery.refresh.entities.User;
import com.skilldistillery.refresh.repositories.KeywordRepository;

@Service
public class KeywordServiceImpl implements KeywordService {

	@Autowired
	private KeywordRepository keywordRepo;


	@Override
	public Keyword getKeywordById(int id) {
		// TODO Auto-generated method stub
		return null;
	}



}
