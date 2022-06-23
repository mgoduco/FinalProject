package com.skilldistillery.refresh.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.Recipe;
import com.skilldistillery.refresh.repositories.RecipeRepository;

@Service
public class RecipeServiceImpl implements RecipeService {

	@Autowired
	private RecipeRepository recipeRepo;

	@Override
	public Recipe getRecipeById(int id) {
		// TODO Auto-generated method stub
		return null;
	}



	

}
