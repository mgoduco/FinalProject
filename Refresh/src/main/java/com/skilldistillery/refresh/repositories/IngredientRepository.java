package com.skilldistillery.refresh.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.refresh.entities.Ingredient;

public interface IngredientRepository extends JpaRepository<Ingredient, Integer> {

	
}
