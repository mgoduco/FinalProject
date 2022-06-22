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
import javax.persistence.OneToMany;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;

	private String password;

	private String email;

	private String role;

	private boolean enabled;

	@CreationTimestamp
	private LocalDateTime created;

	@UpdateTimestamp
	private LocalDateTime updated;

	@Column(name = "image_url")
	private String imageUrl;

	private String firstName;

	private String lastName;

	private String biography;

//	@Cascade(CascadeType.PERSIST)
//	@LazyCollection(LazyCollectionOption.FALSE)
//	@JsonIgnoreProperties({"user"})
	@OneToMany(mappedBy = "user")
	@JsonIgnore
	private List<MadeThis> madeThisList;

//	@Cascade(CascadeType.PERSIST)
//	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "user")
	@JsonIgnore
	private List<Recipe> recipes;

//	@Cascade(CascadeType.PERSIST)
//	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy = "user")
	@JsonIgnore
	private List<Comment> comments;
	
	
	public User() {
		super();
	}

// =============================================
	public void addMadeThis(MadeThis madeThis) {
		if (madeThisList == null) {
			madeThisList = new ArrayList<>();

		}
		if (!madeThisList.contains(madeThis)) {
			madeThisList.add(madeThis);
			madeThis.setUser(this);
		}
	}
	public void removeMadeThis(MadeThis madeThis) {
		if (madeThisList != null && madeThisList.contains(madeThis)) {
			madeThisList.remove(madeThis);
			madeThis.setUser(null);
		}
	}
	
	public void addRecipe(Recipe recipe) {
		if (recipes == null) {
			recipes = new ArrayList<>();
			
		}
		if (!recipes.contains(recipe)) {
			recipes.add(recipe);
			recipe.setUser(this);
		}
	}
	public void removeRecipe(Recipe recipe) {
		if (recipes != null && recipes.contains(recipe)) {
			recipes.remove(recipe);
			recipe.setUser(null);
		}
	}
	
	public void addComment(Comment comment) {
		if (comments == null) {
			comments = new ArrayList<>();
			
		}
		if (!comments.contains(comment)) {
			comments.add(comment);
			comment.setUser(this);
		}
	}
	public void removeComment(Comment comment) {
		if (comments != null && comments.contains(comment)) {
			comments.remove(comment);
			comment.setUser(null);
		}
	}
// =============================================

	public int getId() {
		return id;
	}

	public List<MadeThis> getMadeThisList() {
		return madeThisList;
	}

	public void setMadeThisList(List<MadeThis> madeThisList) {
		this.madeThisList = madeThisList;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
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

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getBiography() {
		return biography;
	}

	public void setBiography(String biography) {
		this.biography = biography;
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
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", email=" + email + ", role="
				+ role + ", enabled=" + enabled + ", created=" + created + ", updated=" + updated + ", imageUrl="
				+ imageUrl + ", firstName=" + firstName + ", lastName=" + lastName + ", biography=" + biography + "]";
	}

}
