package com.skilldistillery.refresh.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Recipe {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	private String description;

	private String directions;

	@CreationTimestamp
	private LocalDateTime created;

	@UpdateTimestamp
	private LocalDateTime updated;

	private boolean active;

	private int prepMinutes;

	private int cookMinutes;

	@Column(name = "image_url")
	private String imageUrl;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	@JsonIgnore
	@OneToMany(mappedBy = "recipe")
	private List<Comment> comments;
	
	@JsonIgnore
	@OneToMany(mappedBy = "recipe")
	private List<RecipePhoto> photos;

	@OneToMany(mappedBy = "recipe")
	@Cascade(CascadeType.PERSIST)
	@JsonIgnore
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<MadeThis> madeThisList;

	@OneToMany(mappedBy = "recipe")
	@Cascade(CascadeType.PERSIST)
	@JsonIgnore
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<RecipeIngredient> recipeIngredients;
	
	public Recipe() {
		super();
	}
//	===========================================
	public void addRecipeIngredient(RecipeIngredient recipeIngredient) {
		if (recipeIngredients == null) {
			recipeIngredients = new ArrayList<>();
			
		}
		if (!recipeIngredients.contains(recipeIngredient)) {
			recipeIngredients.add(recipeIngredient);
			recipeIngredient.setRecipe(this);
		}
	}
	public void removeRecipeIngredient(RecipeIngredient recipeIngredient) {
		if (recipeIngredients != null && recipeIngredients.contains(recipeIngredient)) {
			recipeIngredients.remove(recipeIngredient);
			recipeIngredient.setRecipe(null);
		}
	}
	
	public void addMadeThis(MadeThis madeThis) {
		if (madeThisList == null) {
			madeThisList = new ArrayList<>();

		}
		if (!madeThisList.contains(madeThis)) {
			madeThisList.add(madeThis);
			madeThis.setRecipe(this);
		}
	}
	public void removeMadeThis(MadeThis madeThis) {
		if (madeThisList != null && madeThisList.contains(madeThis)) {
			madeThisList.remove(madeThis);
			madeThis.setRecipe(null);
		}
	}
	
	public void addPhoto(RecipePhoto recipePhoto) {
		if (photos == null) {
			photos = new ArrayList<>();
			
		}
		if (!photos.contains(recipePhoto)) {
			photos.add(recipePhoto);
			recipePhoto.setRecipe(this);
		}
	}
	public void removePhoto(RecipePhoto recipePhoto) {
		if (photos != null && photos.contains(recipePhoto)) {
			photos.remove(recipePhoto);
			recipePhoto.setRecipe(null);
		}
	}
	
	public void addComment(Comment comment) {
		if (comments == null) {
			comments = new ArrayList<>();
			
		}
		if (!comments.contains(comment)) {
			comments.add(comment);
			comment.setRecipe(this);
		}
	}
	public void removeComment(Comment comment) {
		if (comments != null && comments.contains(comment)) {
			comments.remove(comment);
			comment.setRecipe(null);
		}
	}
//	===========================================	
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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

	public String getDirections() {
		return directions;
	}

	public void setDirections(String directions) {
		this.directions = directions;
	}

	public LocalDateTime getCreated() {
		return created;
	}

	public void setCreated(LocalDateTime created) {
		this.created = created;
	}

	public LocalDateTime getUpdated() {
		return updated;
	}

	public void setUpdated(LocalDateTime updated) {
		this.updated = updated;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public int getPrepMinutes() {
		return prepMinutes;
	}

	public void setPrepMinutes(int prepMinutes) {
		this.prepMinutes = prepMinutes;
	}

	public int getCookMinutes() {
		return cookMinutes;
	}

	public void setCookMinutes(int cookMinutes) {
		this.cookMinutes = cookMinutes;
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
		Recipe other = (Recipe) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Recipe [id=" + id + ", name=" + name + ", description=" + description + ", directions=" + directions
				+ ", created=" + created + ", updated=" + updated + ", active=" + active + ", prepMinutes="
				+ prepMinutes + ", cookMinutes=" + cookMinutes + ", imageUrl=" + imageUrl + "]";
	}

}

//| user_id     | int(11)       | NO   | MUL | NULL    |       |
