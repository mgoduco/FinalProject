package com.skilldistillery.refresh.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Table(name = "recipe_photo")
@Entity
public class RecipePhoto {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "image_url")
	private String imageUrl;

	@Column(name = "sequence_number")
	private int sequenceNumber;

	private String caption;

	@ManyToOne
	@JoinColumn(name = "recipe_id")
	private Recipe recipe;

	public RecipePhoto() {
		super();
	}

	public Recipe getRecipe() {
		return recipe;
	}

	public void setRecipe(Recipe recipe) {
		this.recipe = recipe;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public int getSequenceNumber() {
		return sequenceNumber;
	}

	public void setSequenceNumber(int sequenceNumber) {
		this.sequenceNumber = sequenceNumber;
	}

	public String getCaption() {
		return caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RecipePhoto other = (RecipePhoto) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "RecipePhoto [id=" + id + ", imageUrl=" + imageUrl + ", sequenceNumber=" + sequenceNumber + ", caption="
				+ caption + "]";
	}

}

//| recipe_id       | int(11)       | NO   | MUL | NULL    |                |
