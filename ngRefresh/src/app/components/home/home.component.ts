
import { Component, OnInit, ViewChild } from '@angular/core';
import { NgbCarousel, NgbSlideEvent, NgbSlideEventSource } from '@ng-bootstrap/ng-bootstrap';
import { ActivatedRoute, Router } from '@angular/router';
import { Recipe } from 'src/app/models/recipe';
import { RecipeService } from 'src/app/services/recipe.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  recipe: null | Recipe = null;
  recipes: Recipe [] = [];
  selected: null | Recipe = null;

  constructor(private recipeServ: RecipeService, private userServ: UserService, private route: ActivatedRoute,
    private router: Router) { }

    ngOnInit(): void {
      let idStr = this.route.snapshot.paramMap.get('id');
      if (!this.selected && idStr) {
        try{
        let idNum = Number.parseInt(idStr);
      this.recipeServ.show(idNum).subscribe({
        next: (theRecipe) => {
        this.selected = theRecipe;
        },
        error: (fail) =>{
          this.router.navigateByUrl('/todoNotFound')
        }
      });
        }catch (error){
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

  displayTodo(recipe: Recipe) {
    this.selected = recipe;
  }

  displayTable() {
    this.selected = null;
  }







}


