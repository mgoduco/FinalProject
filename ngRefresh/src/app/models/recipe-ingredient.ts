import { Ingredient } from './ingredient';
import { Recipe } from './recipe';
export class RecipeIngredient {
  recipe: Recipe | null | undefined;
  ingredient: Ingredient | null | undefined;
  amount: number | null;
  measure: string | null;
  preparation: string | null;

  constructor(
    recipe: Recipe = new Recipe(),
    // TODO ?????????????????
    ingredient: Ingredient = new Ingredient(),
    amount: number | null = 0,
    measure: string | null = '',
    preparation: string | null = ''
  ) {
    this.recipe = recipe;
    this.ingredient = ingredient;
    this.amount = amount;
    this.measure = measure;
    this.preparation = preparation;
  }
}
