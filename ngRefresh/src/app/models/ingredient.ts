import { RecipeIngredient } from './recipe-ingredient';
export class Ingredient {
  id: number | null;
  name: string | null;
  description: string | null;
  imageUrl: string | null;
  kcals: number | null;
  // recipeIngredients: RecipeIngredient[] | any;


  constructor(
    id: number | null = 0,
    name: string | null = '',
    description: string | null = '',
    imageUrl: string | null = '',
    kcals: number | null = 0,
    // recipeIngredients: RecipeIngredient[] | []

  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.imageUrl = imageUrl;
    this.kcals = kcals;
    // this.recipeIngredients = recipeIngredients
  }
}
