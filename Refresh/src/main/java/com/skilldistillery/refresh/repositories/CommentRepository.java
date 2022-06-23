package com.skilldistillery.refresh.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.refresh.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

}
