import { RecipeIngredient } from './recipe-ingredient';
import { MadeThis } from "./made-this";
import { RecipePhoto } from "./recipe-photo";
import { User } from "./user";

export class Recipe {
  id: number | null;
  name: string | null;
  description: string | null;
  directions: string | null;
  // created
  // updated
  user: User;
  active: boolean | false;
  prepminutes: number | null;
  cookminutes: number | null;
  imageUrl: string;
  comments: Comment[] | any;
  photos: RecipePhoto[] | any;
  madeThisList: MadeThis[] | any;
  recipeIngredients: RecipeIngredient[] | any;
  userFavorites: User[] | any;
  //keywords

  constructor(
    id: number | null = 0,
    name: string | null = '',
    description: string | null = '',
    directions: string | null = '',
    user: User,
    active: boolean = false,
    prepminutes: number | null = 0,
    cookminutes: number | null = 0,
    imageUrl: string = '',
    comments: Comment[] | [],
    photos: RecipePhoto[] | [],
    madeThisList: MadeThis[] | [],
    recipeIngredients: RecipeIngredient[] | [],
    userFavorites: User[] | [],
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.directions = directions;
    this.user = user;
    this.active = active;
    this.prepminutes = prepminutes;
    this.cookminutes = cookminutes;
    this.imageUrl = imageUrl;
    this.comments = comments;
    this.photos = photos;
    this.madeThisList = madeThisList;
    this.recipeIngredients = recipeIngredients;
    this.userFavorites = userFavorites;

  }
}
