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

class RecipeTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Recipe recipe;

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
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		recipe = null;
	}

	@Test
	@DisplayName("Testing basic mapping")
	void test1() {
		assertNotNull(recipe);
		assertEquals("Gourmet Peanut Butter and Jelly", recipe.getName());
	}
	@Test
	@DisplayName("Testing user MTO mapping")
	void test2() {
		assertNotNull(recipe.getUser());
		assertEquals("amateur", recipe.getUser().getUsername());
	}
	@Test
	@DisplayName("Testing comment OTM mapping")
	void test3() {
		assertNotNull(recipe);
		assertTrue(recipe.getComments().size() > 0);
	}
	@Test
	@DisplayName("Testing recipe photo OTM mapping")
	void test4() {
		assertNotNull(recipe);
		assertTrue(recipe.getPhotos().size() > 0);
	}
	@Test
	@DisplayName("Testing madethis OTM mapping")
	void test5() {
		assertNotNull(recipe);
		assertTrue(recipe.getMadeThisList().size() > 0);
	}
	@Test
	@DisplayName("Testing ingredients OTM mapping")
	void test6() {
		assertNotNull(recipe);
		assertEquals("Peanut Butter", recipe.getRecipeIngredients().get(0).getIngredient().getName());
	}
	@Test
	@DisplayName("Testing favorite MTM mapping")
	void test7() {
		assertNotNull(recipe);
		assertEquals("Gourmet Peanut Butter and Jelly", recipe.getUserFavorites().get(0).getFavoriteRecipes().get(0).getName());
	}

}