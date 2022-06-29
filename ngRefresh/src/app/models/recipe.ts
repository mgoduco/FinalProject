import { RecipeIngredient } from './recipe-ingredient';
import { MadeThis } from "./made-this";
import { RecipePhoto } from "./recipe-photo";
import { User } from "./user";

export class Recipe {
  id: number;
  name: string;
  description: string;
  directions: string;
  // created
  // updated
  // user: User;
  active: boolean;
  prepminutes: number;
  cookminutes: number;
  imageUrl: string;
  // comments: Comment[];
  // photos: RecipePhoto[];
  // madeThisList: MadeThis[];
  recipeIngredients: RecipeIngredient[];
  // userFavorites: User[];
  //keywords

  constructor(
    id: number = 0,
    name: string = '',
    description: string = '',
    directions: string  = '',
    // user: User,
    active: boolean = false,
    prepminutes: number = 0,
    cookminutes: number  = 0,
    imageUrl: string = '',
    // comments: Comment[] | [],
    // photos: RecipePhoto[] | [],
    // madeThisList: MadeThis[] | [],
    recipeIngredients: RecipeIngredient[] = [],
    // userFavorites: User[] | [],
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.directions = directions;
    // this.user = user;
    this.active = active;
    this.prepminutes = prepminutes;
    this.cookminutes = cookminutes;
    this.imageUrl = imageUrl;
    // this.comments = comments;
    // this.photos = photos;
    // this.madeThisList = madeThisList;
    this.recipeIngredients = recipeIngredients;
    // this.userFavorites = userFavorites;

  }
}
