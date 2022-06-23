package com.skilldistillery.refresh.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class RecipeIngredientTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Recipe recipe;
	private Ingredient ingredient;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPARefresh");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		recipe = em.find(Recipe.class, 1);
		ingredient = em.find(Ingredient.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		recipe = null;
		ingredient = null;
	}

	@Test
	@DisplayName("Testing basic mapping")
	void test1() {
		assertNotNull(recipe);
		assertEquals("Peanut Butter", recipe.getRecipeIngredients().get(0).getIngredient().getName());
	}
	@Test
	@DisplayName("Testing recipe MTO mapping")
	void test2() {
		assertNotNull(recipe);
		assertEquals("Peanut Butter", recipe.getRecipeIngredients().get(0).getIngredient().getName());
	}
	@Test
	@DisplayName("Testing ingredient MTO mapping")
	void test3() {
		assertNotNull(ingredient);
		assertEquals("Peanut Butter", ingredient.getRecipeIngredients().get(0).getIngredient().getName());
	}

}