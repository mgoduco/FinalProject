import { CommentService } from './../../services/comment.service';

import { Component, OnInit, ViewChild } from '@angular/core';
import { NgbCarousel, NgbSlideEvent, NgbSlideEventSource } from '@ng-bootstrap/ng-bootstrap';
import { ActivatedRoute, Router } from '@angular/router';
import { Recipe } from 'src/app/models/recipe';
import { RecipeService } from 'src/app/services/recipe.service';
import { UserService } from 'src/app/services/user.service';
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons';
import { Comment } from 'src/app/models/comment';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  recipe: null | Recipe = null;
  recipes: Recipe [] = [];
  selected: null | Recipe = null;
  isSelected: boolean = false;
  comments: Comment [] = [];


  // Icons
  faArrowLeft = faArrowLeft;

  constructor(
    private recipeServ: RecipeService,
    private userServ: UserService,
    private route: ActivatedRoute,
    private commentServ: CommentService,
    private router: Router) { }

    // ngOnInit(): void {
    //   let idStr = this.route.snapshot.paramMap.get('id');
    //   if (!this.selected && idStr) {
    //     try{
    //     let idNum = Number.parseInt(idStr);
    //   this.recipeServ.show(idNum).subscribe({
    //     next: (theRecipe) => {
    //     this.selected = theRecipe;
    //     },
    //     error: (fail) =>{
    //       this.router.navigateByUrl('/todoNotFound')
    //     }
    //   });
    //     }catch (error){
    //     }
    //   }
    //   this.reload();
    // }

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
        }
        else {
          this.router.navigateByUrl('/invalidRecipeId');
        }
      }
      this.reload();
    }

  reload(): void{
    this.recipeServ.index().subscribe({
      next: (dbRecipes) => {this.recipes = dbRecipes; console.log(dbRecipes)},
      error: (fail: any) => {
        console.error('HomeComonent.reload: error');
        console.error(fail);
      }
    })
  }

  displayRecipe(recipe: Recipe) {
    this.selected = recipe;
    this.isSelected = true;
    console.log(recipe);
    console.log(this.selected);
  }

  displayTable() {
    this.selected = null;
  }


  getRecipeComments(recipe: Recipe){
    this.commentServ.getAllCommentsByRecipe(recipe).subscribe({
      next: (data) => {this.comments = data;},
      error: (fail: any) => {
        console.error('HomeComponent.reload: error');
        console.error(fail);
      }
    })
  }



}


