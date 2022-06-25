export class RecipePhoto {

  // TODO FIX RECIPE PHOTO LIKE OTHER MODELS
  id: number | null;
  image_url: string | null;
  sequence_number: number | null;
  caption: string | null;
  recipe_id: number | null;

  constructor(
    id: number | null = 0,
    image_url: string | null = '',
    sequence_number: number | null = 0,
    caption: string | null = '',
    recipe_id: number | null = 0
  ) {
    this.id = id;
    this.image_url = image_url;
    this.sequence_number = sequence_number;
    this.caption = caption;
    this.recipe_id = recipe_id;
  }
}
