package com.skilldistillery.refresh.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.MadeThis;
import com.skilldistillery.refresh.repositories.MadeThisRepository;

@Service
public class MadeThisServiceImpl implements MadeThisService {

	@Autowired
	private MadeThisRepository madeThisRepo;

	@Override
	public MadeThis getMadeThisById(int id) {
		// TODO Auto-generated method stub
		return null;
	}








}
