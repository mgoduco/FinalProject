export class MadeThis {
  user_id: number | null;
  recipe_id: number | null;
  // makedate
  rating: number | null;
  comment: string | null;
  image_url: string | null;
  active: boolean | false;

  constructor(
    user_id: number | null = 0,
    recipe_id: number | null = 0,
    rating: number | null = 0,
    comment: string | null = '',
    image_url: string | null = '',
    active: boolean = false
  ) {
    this.user_id = user_id;
    this.recipe_id = recipe_id;
    this.rating = rating;
    this.comment = comment;
    this.image_url = image_url;
    this.active = active;
  }
}
