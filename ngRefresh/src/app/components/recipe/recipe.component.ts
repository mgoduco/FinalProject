import { AuthService } from 'src/app/services/auth.service';
import { Recipe } from 'src/app/models/recipe';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { RecipeService } from 'src/app/services/recipe.service';
import { UserService } from 'src/app/services/user.service';
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons';
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
  editSelected: boolean = false;
  isSelected: boolean = false;
  isCreateSelected: boolean = false;
  isCreateTableSelected: boolean = false;
  recipeSelected: boolean = false;
  user: User = new User();

  // Icons
  faArrowLeft = faArrowLeft;
  constructor(
    private recipeServ: RecipeService,
    private userServ: UserService,
    private route: ActivatedRoute,
    private router: Router,
    private auth: AuthService
  ) {}

  ngOnInit(): void {
    this.getUser();
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

  displayCreateTable() {
    this.isCreateTableSelected = true;
  }
  displayCreate() {
    this.isSelected = true;
  }

  createRecipe(recipe: Recipe) {
    this.recipeServ.create(recipe).subscribe({
      next: (newRecipe) => {
        this.newRecipe = new Recipe();
        this.reload();
      },
      error: (fail) => {
        console.error('RecipeComponent.addTodo: error creating recipe');
        console.error(fail);
      },
    });
  }
  displayRecipe(recipe: Recipe) {
    this.selected = recipe;
    this.recipeSelected = true;
    console.log(recipe);
    console.log(this.selected);
  }

  displayTable() {
    this.selected = null;
    this.isSelected = false;
    this.isCreateSelected = false;
    this.isCreateTableSelected = false;
  }

  updateRecipe(recipe: Recipe) {
    this.recipeServ.update(recipe).subscribe({
      next: (newRecipe) => {
        this.newRecipe = new Recipe();
        this.reload();
      },
      error: (fail) => {
        console.error('RecipeComponent.addTodo: error creating recipe');
        console.error(fail);
      },
    });
  }
}
