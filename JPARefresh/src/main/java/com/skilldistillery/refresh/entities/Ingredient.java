package com.skilldistillery.refresh.entities;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Ingredient {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	private String description;

	@Column(name = "image_url")
	private String imageUrl;

	@Column(name = "kcals_per_serving")
	private Integer kcals;

//	@Cascade(CascadeType.PERSIST)
//	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "ingredient")
	@JsonIgnore
	private List<RecipeIngredient> recipeIngredients;

	public Ingredient() {
		super();
	}

//	===========================================
	public void addRecipeIngredient(RecipeIngredient recipeIngredient) {
		if (recipeIngredients == null) {
			recipeIngredients = new ArrayList<>();

		}
		if (!recipeIngredients.contains(recipeIngredient)) {
			recipeIngredients.add(recipeIngredient);
			recipeIngredient.setIngredient(this);
		}
	}

	public void removeRecipeIngredient(RecipeIngredient recipeIngredient) {
		if (recipeIngredients != null && recipeIngredients.contains(recipeIngredient)) {
			recipeIngredients.remove(recipeIngredient);
			recipeIngredient.setIngredient(null);
		}
	}
//	===========================================

	public int getId() {
		return id;
	}

	public List<RecipeIngredient> getRecipeIngredients() {
		return recipeIngredients;
	}

	public void setRecipeIngredients(List<RecipeIngredient> recipeIngredients) {
		this.recipeIngredients = recipeIngredients;
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

	public Integer getKcals() {
		return kcals;
	}

	public void setKcals(Integer kcals) {
		this.kcals = kcals;
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
		Ingredient other = (Ingredient) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Ingredient [id=" + id + ", name=" + name + ", description=" + description + ", imageUrl=" + imageUrl
				+ ", kcals=" + kcals + "]";
	}

}
