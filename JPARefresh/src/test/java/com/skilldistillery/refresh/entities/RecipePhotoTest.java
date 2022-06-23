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

class RecipePhotoTest {
	private static EntityManagerFactory emf;
	private EntityManager em;
	private RecipePhoto recipePhoto;

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
		recipePhoto = em.find(RecipePhoto.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		recipePhoto = null;
	}

	@Test
	@DisplayName("Testing basic mapping")
	void test1() {
		assertNotNull(recipePhoto);
		assertEquals("https://www.thespruceeats.com/thmb/SVQ74a8W5PcgeZRsKN3sNozZJRw=/580x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/gourmet-peanut-butter-and-jelly-recipe-305473-step-01-5426378fe0a84f508e40081292fe5289.jpg", recipePhoto.getImageUrl());
	}
	@Test
	@DisplayName("Testing recipe MTO mapping")
	void test2() {
		assertNotNull(recipePhoto.getRecipe());
		assertEquals(1, recipePhoto.getRecipe().getId());
		assertEquals("Gourmet Peanut Butter and Jelly", recipePhoto.getRecipe().getName());
	}

}