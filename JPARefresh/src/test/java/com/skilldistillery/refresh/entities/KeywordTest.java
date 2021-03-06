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

class KeywordTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Keyword keyword;

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
		keyword = em.find(Keyword.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		keyword = null;
	}

	@Test
	@DisplayName("Testing basic mapping")
	void test1() {
		assertNotNull(keyword);
		assertEquals("pbnj", keyword.getName());
	}
	@Test
	@DisplayName("Testing tag MTM mapping")
	void test2() {
		assertNotNull(keyword);
		assertTrue(keyword.getTaggedRecipes().size() > 0);
	}

}