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
  newRecipe: Recipe = new Recipe();
  recipes: Recipe[] = [];
  selected: null | Recipe = null;
  isSelected: boolean = false;
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
      }
    })
    console.log(this.user);
  }
  reload(): void {
    this.recipeServ.index().subscribe({
      next: (dbRecipes) => {
        this.recipes = dbRecipes;
        console.log(dbRecipes);
      },
      error: (fail: any) => {
        console.error('RecipeComp.reload: error');
        console.error(fail);
      },
    });
  }
  displayUserRecipes() {
    // this.getUser();
    // this.recipeServ.recipesByUsername().subscribe({
    //   next: (data) => {
    //     this.recipes = data;
    //     console.log(data);
    //   },
    //   error: (fail: any) => {
    //     console.error('RecipeComp.reload: error');
    //     console.error(fail);
    //   },
    // });
  }

  displayTable() {
    this.isSelected = false;
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
