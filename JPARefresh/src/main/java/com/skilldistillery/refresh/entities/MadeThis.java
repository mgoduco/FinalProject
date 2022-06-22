package com.skilldistillery.refresh.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name = "made_this")
public class MadeThis {

	@EmbeddedId
	private MadeThisId id = new MadeThisId();

	@CreationTimestamp
	private LocalDateTime makeDate;

	private int rating;

	private String comment;

	@Column(name = "image_url")
	private String imageUrl;

	@ManyToOne
	@JoinColumn(name = "user_id")
	@MapsId(value = "userId")
	private User user;

	@ManyToOne
	@JoinColumn(name = "recipe_id")
	@MapsId(value = "recipeId")
	private Recipe recipe;

	public MadeThis() {
		super();
	}

	public MadeThisId getId() {
		return id;
	}

	public void setId(MadeThisId id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Recipe getRecipe() {
		return recipe;
	}

	public void setRecipe(Recipe recipe) {
		this.recipe = recipe;
	}

	public LocalDateTime getMakeDate() {
		return makeDate;
	}

	public void setMakeDate(LocalDateTime makeDate) {
		this.makeDate = makeDate;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	@Override
	public String toString() {
		return "MadeThis [makeDate=" + makeDate + ", rating=" + rating + ", comment=" + comment + ", imageUrl="
				+ imageUrl + "]";
	}

}

