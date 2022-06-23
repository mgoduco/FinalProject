package com.skilldistillery.refresh.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class UserTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	@DisplayName("Testing basic Mapping")
	void test1() {
		assertNotNull(user);
		assertEquals("chef", user.getUsername());
	}
	@Test
	@DisplayName("Testing madethis OTM Mapping")
	void test2() {
		assertNotNull(user.getMadeThisList());
		assertEquals("Gourmet Peanut Butter and Jelly", user.getMadeThisList().get(0).getRecipe().getName());
	}
	@Test
	@DisplayName("Testing recipes OTM Mapping")
	void test3() {
		assertNotNull(user.getRecipes());
		//TODO ADD TO DB 
		assertTrue(user.getRecipes().size() > 0);
	}
	@Test
	@DisplayName("Testing favorites MTM Mapping")
	void test4() {
		assertNotNull(user.getFavoriteRecipes());
		//TODO ADD TO DB 
		assertFalse(user.getFavoriteRecipes().size() > 0);
	}
	@Test
	@DisplayName("Testing comments OTM Mapping")
	void test5() {
		assertNotNull(user.getComments());
		assertTrue(user.getComments().size() > 0);
	}

}
