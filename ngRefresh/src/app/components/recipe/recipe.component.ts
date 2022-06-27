import { Recipe } from 'src/app/models/recipe';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { RecipeService } from 'src/app/services/recipe.service';
import { UserService } from 'src/app/services/user.service';
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons';

@Component({
  selector: 'app-recipe',
  templateUrl: './recipe.component.html',
  styleUrls: ['./recipe.component.css'],
})
export class RecipeComponent implements OnInit {
  recipe: null | Recipe = null;
  selected: null | Recipe = null;
  editRecipe: null | Recipe = null;
  newRecipe: Recipe = new Recipe();
  recipes: Recipe[] = [];
  isSelected: boolean = false;
  isEditSelected: boolean = false;

  // Icons
  faArrowLeft = faArrowLeft;
  constructor(
    private recipeServ: RecipeService,
    private userServ: UserService,
    private route: ActivatedRoute,
    private router: Router
  ) {}

  ngOnInit(): void {
    let idStr = this.route.snapshot.paramMap.get('id');
    if (!this.selected && idStr) {
      let idNum = Number.parseInt(idStr);
      if (!isNaN(idNum)) {
        this.recipeServ.show(idNum).subscribe({
          next: (theRecipe) => {
            this.selected = theRecipe;
          },
          error: (fail) => {
            this.router.navigateByUrl('/recipeNotFound');
          },
        });
      } else {
        this.router.navigateByUrl('/invalidRecipeId');
      }
    }
    this.reload();
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
  updateRecipe(recipe: Recipe, setSelected: boolean = true):void {
    this.recipeServ.update(recipe).subscribe({
      next: (updated) => {
        this.reload();
        if (setSelected) {
          this.selected = updated;
        }
        this.selected = null;
        this.newRecipe = new Recipe();
      },
      error: (fail) => {
        console.error('RecipeComponent.addTodo: error creating recipe');
        console.error(fail);
      },
    });
  }
}
