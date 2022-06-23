package com.skilldistillery.refresh.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.Ingredient;
import com.skilldistillery.refresh.repositories.IngredientRepository;

@Service
public class IngredientServiceImpl implements IngredientService {

	@Autowired
	private IngredientRepository ingredientRepo;

	@Override
	public Ingredient getIngredientById(int id) {
		// TODO Auto-generated method stub
		return null;
	}


	

}
