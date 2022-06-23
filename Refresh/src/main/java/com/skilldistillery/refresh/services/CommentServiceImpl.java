package com.skilldistillery.refresh.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.refresh.entities.Comment;
import com.skilldistillery.refresh.repositories.CommentRepository;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentRepository commentRepo;

	@Override
	public Comment getCommentById(int id) {
		// TODO Auto-generated method stub
		return null;
	}

}
