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

class CommentTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Comment comment;

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
		comment = em.find(Comment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		comment = null;
	}

	@Test
	@DisplayName("Testing basic mappings")
	void test1() {
		assertNotNull(comment);
		assertEquals("Mmmm....Delicious!" ,comment.getTitle());
		assertEquals("This is the best PB&J I have ever tasted!" ,comment.getComment());
	}
	@Test
	@DisplayName("Testing user mappings")
	void test2() {
		assertNotNull(comment.getUser());
		assertEquals("amateur" ,comment.getUser().getUsername());
	}
	@Test
	@DisplayName("Testing recipe mappings")
	void test3() {
		assertNotNull(comment.getRecipe());
		assertEquals("Gourmet Peanut Butter and Jelly" ,comment.getRecipe().getName());
	}
	
	//TODO COME BACK TO REPLY!!!!!!!!!!
	@Test
	@DisplayName("Testing reply mappings")
	void test4() {
		comment = em.find(Comment.class, 2);
		assertNotNull(comment.getInReplyTo());
		assertEquals("Mmmm....Delicious!", comment.getInReplyTo().getTitle());
	}
	@Test
	@DisplayName("Testing reply mappings")
	void test5() {
		assertNotNull(comment.getReplies());
		assertTrue(comment.getReplies().size() > 0);
	}

}