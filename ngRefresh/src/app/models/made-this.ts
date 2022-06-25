import { Recipe } from "./recipe";
import { User } from "./user";

export class MadeThis {
  user: User;
  recipe: Recipe;
  // makedate
  rating: number | null;
  comment: string | null;
  imageUrl: string | null;
  active: boolean | false;

  constructor(
    user: User = new User,
    recipe: Recipe = new Recipe,
    rating: number | null = 0,
    comment: string | null = '',
    imageUrl: string | null = '',
    active: boolean = false
  ) {
    this.user = user;
    this.recipe = recipe;
    this.rating = rating;
    this.comment = comment;
    this.imageUrl = imageUrl;
    this.active = active;
  }
}
