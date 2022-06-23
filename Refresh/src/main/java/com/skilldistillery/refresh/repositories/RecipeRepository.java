package com.skilldistillery.refresh.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.refresh.entities.Recipe;

public interface RecipeRepository extends JpaRepository<Recipe, Integer> {

	
}
