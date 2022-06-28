import { AuthService } from 'src/app/services/auth.service';
import { Ingredient } from './../../models/ingredient';
import { CommentService } from './../../services/comment.service';

import { Component, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Recipe } from 'src/app/models/recipe';
import { RecipeService } from 'src/app/services/recipe.service';
import {
  faArrowLeft,
  faCircleMinus,
  faCommentMedical,
  faCommentSlash,
} from '@fortawesome/free-solid-svg-icons';
import { Comment } from 'src/app/models/comment';
import { IngredientService } from 'src/app/services/ingredient.service';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
})
export class HomeComponent implements OnInit {
  recipe: null | Recipe = null;
  recipes: Recipe[] = [];
  selected: null | Recipe = null;
  isSelected: boolean = false;
  comments: Comment[] = [];
  ingredients: Ingredient[] = [];
  comment: null | Comment = null;
  newComment: Comment = new Comment(
    null,
    null,
    null,
    null,
    false,
    null,
    null,
    null
  );

  // Icons
  faArrowLeft = faArrowLeft;
  facomment = faCommentMedical;
  faminus = faCircleMinus;
  famessage = faCommentSlash;

  constructor(
    private recipeServ: RecipeService,
    private route: ActivatedRoute,
    private commentServ: CommentService,
    private ingredientServ: IngredientService,
    private auth: AuthService,
    private router: Router) {

    }

  ngOnInit(): void {

    let idStr = this.route.snapshot.paramMap.get('id');
    if (!this.selected && idStr) {
      let idNum = Number.parseInt(idStr);
      if (!isNaN(idNum)) {
        this.recipeServ.show(idNum).subscribe({
          next: (theRecipe) => {
            this.selected = theRecipe;
          },
          error: () => {
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
        console.error('HomeComonent.reload: error');
        console.error(fail);
      },
    });
  }

  displayRecipe(recipe: Recipe) {
    this.selected = recipe;
    this.isSelected = true;
    console.log(recipe);
    console.log(this.selected);
    let id = this.selected.id;
    if (id != null) {
      this.getIngredientsByrecipe(id);
      this.getRecipeComments(id);
    }
  }

  displayTable() {
    this.selected = null;
  }

  getRecipeComments(id: number) {
    console.log(id);
    this.commentServ.getAllCommentsByRecipe(id).subscribe({
      next: (data) => {
        this.comments = data;
        console.log(data);
      },
      error: (fail: any) => {
        console.error('HomeComponent.reload: error');
        console.error(fail);
      },
    });
  }

  getIngredientsByrecipe(id: number) {
    console.log(id);
    this.ingredientServ.indexByRecipe(id).subscribe({
      next: (data) => {
        this.ingredients = data;
        console.log(data);
      },
      error: (fail: any) => {
        console.error('HomeComponent.reload: error');
        console.error(fail);
      },
    });
  }

  getRecipeById(id: number) {
    console.log(id);
    this.recipeServ.show(id).subscribe({
      next: (data) => {
        this.recipe = data;
        console.log(data);
      },
      error: (fail: any) => {
        console.error('HomeComponent.reload: error');
        console.error(fail);
      },
    });
  }

  createComment(comment: Comment, id: number) {
    console.log(comment);
    console.log(id);

    if (id != null && comment != null) {
      comment.active = true;
      this.commentServ.create(comment, id).subscribe({
        next: (data) => {
          this.comment = data;
          console.log(data);
          this.getRecipeComments(id);
        },
        error: (fail: any) => {
          console.error('HomeComponent.reload: error');
          console.error(fail);
        },
      });
    }
  }

  deleteComment(comment: Comment, recipe: Recipe) {
    console.log(comment);
    console.log(recipe);
    let id = recipe.id;
    if (comment != null && recipe != null) {
      this.commentServ.delete(comment, recipe).subscribe({
        next: (data) => {
          this.comment = data;
          console.log(data);
          if (id != null) {
            this.getRecipeComments(id);
          }
        },
        error: (fail: any) => {
          console.error('HomeComponent.reload: error');
          console.error(fail);
        },
      });
    }
  }

  @ViewChild('title') commentTitle: any; // accessing the reference element
  @ViewChild('commmentArea') commentSpace: any;

  handleClear(){
      // clearing the value
    this.commentTitle.nativeElement.value = ' ';
    this.commentSpace.nativeElement.value = ' ';
  }

  reloadPage() {
    window.location.reload();
 }

 loggedIn(){
  return this.auth.checkLogin();
}

}
