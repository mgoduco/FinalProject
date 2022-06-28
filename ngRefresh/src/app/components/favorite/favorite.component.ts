import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons';
import { Recipe } from 'src/app/models/recipe';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';
import { RecipeService } from 'src/app/services/recipe.service';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-favorite',
  templateUrl: './favorite.component.html',
  styleUrls: ['./favorite.component.css'],
})

export class FavoriteComponent implements OnInit {

  //recipe: null | Recipe = null;
  recipes: Recipe[] = [];
  selected: null | Recipe = null;
  isSelected: boolean = false;
  // isCreateSelected: boolean = false;
  // isCreateTableSelected: boolean = false;
  recipeSelected: boolean = false;
  user: User = new User();
  favorited: boolean = false;

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

  getUser() {
    this.auth.getLoggedInUser().subscribe({
      next: (data) => {
        this.user = data;
        this.reload();
      },
    });
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
          console.error('FavoriteComponent.reload: error');
          console.error(fail);
        },
      });
    }
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
    // this.isCreateSelected = false;
    // this.isCreateTableSelected = false;
  }

  // setFavorite(recipe: Recipe) {
  //   let userId = this.user.id;
  //   let recipeId = this.selected?.id;
  //   if (userId !== null && recipeId !== null) {
  //     this.userServ.
  //   }
  // }

}
