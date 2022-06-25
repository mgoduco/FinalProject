export class RecipeIngredient {
  recipe_id: number | null;
  ingredient_id: number | null;
  amount: number | null;
  measure: string | null;
  preparation: string | null;

  constructor(
    recipe_id: number | null = 0,
    ingredient_id: number | null = 0,
    amount: number | null = 0,
    measure: string | null = '',
    preparation: string | null = ''
  ) {
    this.recipe_id = recipe_id;
    this.ingredient_id = ingredient_id;
    this.amount = amount;
    this.measure = measure;
    this.preparation = preparation;
  }
}
