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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
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

	private int prepminutes;

	private int cookminutes;

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

//	@Cascade(CascadeType.PERSIST)
//	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "recipe")
	@JsonIgnore
	private List<MadeThis> madeThisList;

//	@Cascade(CascadeType.PERSIST)
//	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "recipe")
	@JsonIgnore
	private List<RecipeIngredient> recipeIngredients;

	@ManyToMany
	@JsonIgnore
	@JoinTable(name = "favorite", joinColumns = @JoinColumn(name = "recipe_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
	private List<User> userFavorites;

	@ManyToMany
	@JsonIgnore
	@JoinTable(name = "tag", joinColumns = @JoinColumn(name = "recipe_id"), inverseJoinColumns = @JoinColumn(name = "keyword_id"))
	private List<Keyword> keywords;

	public Recipe() {
		super();
	}

//	===========================================
	// TODO might be messed up
	public void addTaggedKeyword(Keyword keyword) {
		if (keywords == null) {
			keywords = new ArrayList<>();

		}
		if (!keywords.contains(keyword)) {
			keywords.add(keyword);
			keyword.addTaggedRecipe(this);
		}
	}

	public void removeTaggedKeyword(Keyword keyword) {
		if (keywords != null && keywords.contains(keyword)) {
			keywords.remove(keyword);
			keyword.removeTaggedRecipe(this);
		}
	}

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
			recipeIngredient.setRecipe(this);
		}
	}

	// TODO This may be broken
	public void addFavoriteRecipe(User user) {
		if (userFavorites == null) {
			userFavorites = new ArrayList<>();

		}
		if (!userFavorites.contains(user)) {
			userFavorites.add(user);
			user.addFavoriteRecipe(this);
		}
	}

	public void removeFavoriteRecipe(User user) {
		if (userFavorites != null && userFavorites.contains(user)) {
			userFavorites.remove(user);
			user.removeFavoriteRecipe(this);
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
			madeThis.setRecipe(this);
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
			recipePhoto.setRecipe(this);
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
			comment.setRecipe(this);
		}
	}
//	===========================================	

	public User getUser() {
		return user;
	}

	public List<User> getUserFavorites() {
		return userFavorites;
	}

	public void setUserFavorites(List<User> userFavorites) {
		this.userFavorites = userFavorites;
	}

	public List<Keyword> getKeywords() {
		return keywords;
	}

	public void setKeywords(List<Keyword> keywords) {
		this.keywords = keywords;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<RecipePhoto> getPhotos() {
		return photos;
	}

	public void setPhotos(List<RecipePhoto> photos) {
		this.photos = photos;
	}

	public List<MadeThis> getMadeThisList() {
		return madeThisList;
	}

	public void setMadeThisList(List<MadeThis> madeThisList) {
		this.madeThisList = madeThisList;
	}

	public List<RecipeIngredient> getRecipeIngredients() {
		return recipeIngredients;
	}

	public void setRecipeIngredients(List<RecipeIngredient> recipeIngredients) {
		this.recipeIngredients = recipeIngredients;
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

	public int getPrepminutes() {
		return prepminutes;
	}

	public void setPrepminutes(int prepminutes) {
		this.prepminutes = prepminutes;
	}

	public int getCookminutes() {
		return cookminutes;
	}

	public void setCookminutes(int cookminutes) {
		this.cookminutes = cookminutes;
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
		return "Recipe [id=" + id + ", name=" + name + "]";
	}

}

//| user_id     | int(11)       | NO   | MUL | NULL    |       |
