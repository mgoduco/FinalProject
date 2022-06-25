package com.skilldistillery.refresh.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Table(name = "recipe_ingredient")
@Entity
public class RecipeIngredient {

	@EmbeddedId
	private RecipeIngredientId id; //ROB SAYS NOT NEEDED: = new RecipeIngredientId();

	@ManyToOne
	@JoinColumn(name = "ingredient_id")
	@MapsId(value = "ingredientId")
	private Ingredient ingredient;

	@ManyToOne
	@JoinColumn(name = "recipe_id")
	@MapsId(value = "recipeId")
	private Recipe recipe;

	private int amount;

	private String measure;

	private String preparation;

	public RecipeIngredient() {
		super();
	}
	
	public RecipeIngredient(Ingredient ingredient, Recipe recipe, int amount, String measure, String preparation) {
		super();
		this.ingredient = ingredient;
		this.recipe = recipe;
		this.amount = amount;
		this.measure = measure;
		this.preparation = preparation;
	}

	public RecipeIngredientId getId() {
		return id;
	}

	public void setId(RecipeIngredientId id) {
		this.id = id;
	}

	public Ingredient getIngredient() {
		return ingredient;
	}

	public void setIngredient(Ingredient ingredient) {
		this.ingredient = ingredient;
	}

	public Recipe getRecipe() {
		return recipe;
	}

	public void setRecipe(Recipe recipe) {
		this.recipe = recipe;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getMeasure() {
		return measure;
	}

	public void setMeasure(String measure) {
		this.measure = measure;
	}

	public String getPreparation() {
		return preparation;
	}

	public void setPreparation(String preparation) {
		this.preparation = preparation;
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
		RecipeIngredient other = (RecipeIngredient) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "RecipeIngredient [id=" + id + ", ingredient=" + ingredient + ", recipe=" + recipe + ", amount=" + amount
				+ ", measure=" + measure + ", preparation=" + preparation + "]";
	}

}

//recipe_id     | int(11)     | NO   | PRI | NULL    |       |
//| ingredient_id | int(11)     | NO   | PRI | NULL    |       |
