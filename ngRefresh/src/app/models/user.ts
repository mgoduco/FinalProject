// import { MadeThis } from './made-this';
// import { Recipe } from './recipe';

export class User {
  id: number | null;
  username: string | null;
  password: string | null;
  email: string | null;
  role: string | null;
  enabled: boolean | false;
  // created
  // updated
  imageUrl: string | null;
  firstname: string | null;
  lastname: string | null;
  biography: string | null;
  // madeThisList: MadeThis[] | any;
  // recipes: Recipe[] | any;
  // favoriteRecipes: Recipe[] | any;
  // comments: Comment[] | any;

  constructor(
    id: number | null = 0,
    username: string | null = '',
    password: string | null = '',
    email: string | null = '',
    role: string | null = '',
    enabled: boolean = false,
    // created
    // updated
    imageUrl: string | null = '',
    firstname: string | null = '',
    lastname: string | null = '',
    biography: string | null = '',
    // madeThisList: MadeThis[] | [],
    // recipes: Recipe[] | [],
    // favoriteRecipes: Recipe[] | [],
    // comments: Comment[] | []
  ) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.email = email;
    this.role = role;
    this.enabled = enabled;
    this.imageUrl = imageUrl;
    this.firstname = firstname;
    this.lastname = lastname;
    this.biography = biography;
    // this.madeThisList = madeThisList;
    // this.recipes = recipes;
    // this.favoriteRecipes = favoriteRecipes;
    // this.comments = comments;
  }
}
