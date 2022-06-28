export class Favorite {
  userId: number;
  recipeId: number;
  favorited: boolean;

  constructor(
    userId: number = 0,
    recipeId: number = 0,
    favorited: boolean = false
  ) {
    this.userId = userId;
    this.recipeId = recipeId;
    this.favorited = favorited;
  }
}
