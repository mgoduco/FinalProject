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

class MadeThisTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;
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
		user = em.find(User.class, 1);
		recipe = em.find(Recipe.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
		recipe = null;
	}

	@Test
	@DisplayName("Testing basic mapping")
	void test1() {
		assertNotNull(user);
		assertEquals("Get out of my kitchen.", user.getComments().get(0).getTitle());
	}
	@Test
	@DisplayName("Testing user MTO mapping")
	void test2() {
		assertNotNull(user.getMadeThisList().get(0));
		assertEquals("Get out of my kitchen.", user.getMadeThisList().get(0).getComment());
	}
	@Test
	@DisplayName("Testing recipe MTO mapping")
	void test3() {
		assertNotNull(recipe);
		assertEquals("Get out of my kitchen.", recipe.getMadeThisList().get(0).getComment());
	}

}