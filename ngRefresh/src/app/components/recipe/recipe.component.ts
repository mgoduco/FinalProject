import { RecipeIngredientService } from './../../services/recipe-ingredient.service';
import { RecipeIngredient } from './../../models/recipe-ingredient';
import { IngredientService } from 'src/app/services/ingredient.service';
import { Ingredient } from './../../models/ingredient';
import { AuthService } from 'src/app/services/auth.service';
import { Recipe } from 'src/app/models/recipe';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { RecipeService } from 'src/app/services/recipe.service';
import { UserService } from 'src/app/services/user.service';
import { faArrowLeft, } from '@fortawesome/free-solid-svg-icons';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-recipe',
  templateUrl: './recipe.component.html',
  styleUrls: ['./recipe.component.css'],
})
export class RecipeComponent implements OnInit {
  recipe: null | Recipe = null;
  recipes: Recipe[] = [];
  newRecipe: Recipe = new Recipe();
  selected: null | Recipe = null;
  editSelected: null | Recipe = null;
  isSelected: boolean = false;
  isCreateTableSelected: boolean = false;
  recipeSelected: boolean = false;
  user: User = new User();
  ingredients: Ingredient [] = [];
  allingredients: Ingredient [] = [];
  rIngredients: RecipeIngredient [] = [];

  // Icons
  faArrowLeft = faArrowLeft;

  constructor(
    private ingredientServ: IngredientService,
    private recipeServ: RecipeService,
    private rIngredientServ: RecipeIngredientService,
    private userServ: UserService,
    private route: ActivatedRoute,
    private router: Router,
    private auth: AuthService
  ) {}

  ngOnInit(): void {
    this.getUser();
  }
  nArray(n: number): any[] {
    return Array(n);
}
  getUser(){
    this.auth.getLoggedInUser().subscribe({
      next: (data) => {
        this.user = data;
        this.reload();
      }
    })
    console.log(this.user);
  }

  reload() {
    console.log(this.user.username);
    let username = this.user.username;
    if (username != null) {
      this.recipeServ.recipesByUsername(username).subscribe({
        next: (recipes) => {
          this.recipes = recipes;
          console.log(recipes);
        },
        error: (fail: any) => {
          console.error('RecipeComp.reload: error');
          console.error(fail);
        },
      });
    }
  }
  displayUpdateTable(recipe: Recipe) {
    this.editSelected = recipe;
  }
  displayCreateTable() {
    this.isCreateTableSelected = true;
  }
  displayCreate() {
    this.isSelected = true;
  }

  displayRecipe(recipe: Recipe) {
    this.selected = recipe;
    this.recipeSelected = true;
    this.getIngredientsByrecipe(recipe.id);
  }

  displayTable() {
    this.selected = null;
    this.isSelected = false;
    this.isCreateTableSelected = false;
    this.editSelected = null;
  }



  getIngredientsByrecipe(id: number){
    console.log(id);
    this.ingredientServ.indexByRecipe(id).subscribe({
      next: (data) => {this.ingredients = data; console.log(data)},
      error: (fail: any) => {
        console.error('getIngredients: error');
        console.error(fail);
      }
    })
  }

  // TODO GET ALL INGREDIENTS TO ADD DROP DOWN FOR CREATE RECIPE INGREDIENTS....
  // DO NGFOR TODO EACH INGREDIENT IN DROP DOWN... AND INGREDIENT NAME IS LABEL--
  // ID IS VALUE
  getAllIngredients() {
    this.ingredientServ.index().subscribe({
      next: (data) => {this.allingredients = data; console.log(data)},
      error: (fail: any) => {
        console.error('getIngredients: error');
        console.error(fail);
      }
    })
  }
    // index ingredients

  addIngredient(recipe: Recipe) {
    this.recipeServ.create(recipe).subscribe({
      next: (newRecipe) => {
        this.selected = recipe;
        this.recipeSelected = true;
        this.newRecipe = new Recipe();
        this.reload();
        this.displayTable();
      },
      error: (fail) => {
        console.error('RecipeComponent.createIngredient: error adding ingredient');
        console.error(fail);
      },
    });
  }

  removeIngredient(id: number | null): void {
      if (id != null) {
        this.ingredientServ.destroy(id).subscribe({

          next: () => {
            this.reload();
            this.displayTable();
          },
        });
      }

  }



  createRecipe(recipe: Recipe) {
    this.recipeServ.create(recipe).subscribe({
      next: (newRecipe) => {
        this.selected = recipe;
        this.recipeSelected = true;
        this.newRecipe = new Recipe();
        this.reload();
        this.displayTable();
      },
      error: (fail) => {
        console.error('RecipeComponent.createRecipe: error creating recipe');
        console.error(fail);
      },
    });
  }

  updateRecipe(recipe: Recipe) {
    this.recipeServ.update(recipe).subscribe({
      next: (newRecipe) => {
        this.newRecipe = new Recipe();
        this.reload();
        this.displayTable();
      },
      error: (fail) => {
        console.error('RecipeComponent.addTodo: error creating recipe');
        console.error(fail);
      },
    });
  }

  deleteRecipe(id: number): void {
    this.recipeServ.delete(id).subscribe({
      next: () => {
        this.reload();
        this.reload();
        this.displayTable();
      },
    });
  }

  createRecipeIngredient(rIngredient: RecipeIngredient, recipe: Recipe, ingredient: Ingredient) {
    if (recipe.id != null && ingredient.id != null) {
      this.rIngredientServ.create(rIngredient, recipe.id, ingredient.id).subscribe({
        next: (rIngredient) => {
          this.selected = recipe;
          this.recipeSelected = true;
          this.newRecipe = new Recipe();
          this.reload();
          this.displayTable();
        },
        error: (fail) => {
          console.error('RecipeComponent.createRecipe: error creating recipe');
          console.error(fail);
        },
      });
    }
  }

  updateRecipeIngredient(recipe: Recipe) {
    this.recipeServ.update(recipe).subscribe({
      next: (newRecipe) => {
        this.newRecipe = new Recipe();
        this.reload();
        this.displayTable();
      },
      error: (fail) => {
        console.error('RecipeComponent.addTodo: error creating recipe');
        console.error(fail);
      },
    });
  }

  deleteRecipeIngredient(id: number): void {
    this.recipeServ.delete(id).subscribe({
      next: () => {
        this.reload();
        this.reload();
        this.displayTable();
      },
    });
  }


}

// displayUserRecipes() {
//   this.recipeServ.recipesByUsername(this.user).subscribe({
//     next: (recipes) => {
//       this.recipes = recipes;
//       console.log(recipes);
//     },
//     error: (fail: any) => {
//       console.error('RecipeComp.reload: error');
//       console.error(fail);
//     },
//   });
// }
