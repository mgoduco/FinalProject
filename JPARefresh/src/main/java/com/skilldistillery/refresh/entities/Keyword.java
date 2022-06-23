package com.skilldistillery.refresh.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Keyword {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	private String description;

	@Column(name = "image_url")
	private String imageUrl;

	@ManyToMany
	@JsonIgnore
	@JoinTable(name = "tag", joinColumns = @JoinColumn(name = "keyword_id"), inverseJoinColumns = @JoinColumn(name = "recipe_id"))
	private List<Recipe> taggedRecipes;

//	================================================
	public void addTaggedRecipe(Recipe recipe) {
		if (taggedRecipes == null) {
			taggedRecipes = new ArrayList<>();

		}
		if (!taggedRecipes.contains(recipe)) {
			taggedRecipes.add(recipe);
			recipe.addTaggedKeyword(this);
		}
	}

	public void removeTaggedRecipe(Recipe recipe) {
		if (taggedRecipes != null && taggedRecipes.contains(recipe)) {
			taggedRecipes.remove(recipe);
			recipe.removeTaggedKeyword(this);
		}
	}
//	================================================

	public Keyword() {
		super();
	}

	public List<Recipe> getTaggedRecipes() {
		return taggedRecipes;
	}

	public void setTaggedRecipes(List<Recipe> taggedRecipes) {
		this.taggedRecipes = taggedRecipes;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
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
		Keyword other = (Keyword) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Keyword [id=" + id + ", name=" + name + ", description=" + description + ", imageUrl=" + imageUrl + "]";
	}

}
