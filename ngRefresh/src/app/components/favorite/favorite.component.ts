import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { faHeart as farHeart } from '@fortawesome/free-regular-svg-icons';
import { faCircleArrowLeft, faHeart as fasHeart } from '@fortawesome/free-solid-svg-icons';
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
  favoriteRecipes: Recipe[] = [];
  selected: null | Recipe = null;
  isSelected: boolean = false;
  // isCreateSelected: boolean = false;
  // isCreateTableSelected: boolean = false;
  recipeSelected: boolean = false;
  user: User = new User();
  favorited: boolean = false;

  // Icons
  faCircleArrowLeft = faCircleArrowLeft;
  farHeart = farHeart;
  fasHeart = fasHeart;

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
    let uid = this.user.id;
    if (uid != null) {
      this.userServ.getAllFavorites(uid).subscribe({
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
    this.isFavorite(this.selected.id);
    console.log(recipe);
    console.log(this.selected);
  }

  displayTable() {
    this.selected = null;
    this.isSelected = false;
    // this.isCreateSelected = false;
    // this.isCreateTableSelected = false;
  }

  hearted() {
    if (this.favorited) {
      return fasHeart;
    } else {
      return farHeart;
    }
  }

  toggleFavorite() {
    if (!this.favorited) {
      if (this.selected) {
        this.setFavorite(this.selected);
        this.reload();
        this.displayTable();
      }
    } else {
      if (this.selected) {
        this.removeFavorite(this.selected);
        this.reload();
        this.displayTable();
      }
    }
  }

  isFavorite(rid: number) {
    this.userServ.getFavorite(rid).subscribe({
      next: (favorite) => {
        console.log('Favorite get success!');
        this.favorited = true;
        return true;
      },
      error: (fail: any) => {
        console.log('Favorite is false.');
        this.favorited = false;
        return false;
      },
    });
  }

  setFavorite(recipe: Recipe) {
    let userId = this.user.id;
    console.log('User ID: ' + userId);
    console.log('Selected Recipe:');
    console.log(this.selected);
    if (this.selected !== null) {
      let recipeId = this.selected.id;
      console.log('Recipe ID: ' + recipeId);
      if (userId !== null && recipeId !== null) {
        console.log('Succeessfully created Favorite!');
        this.userServ.addFavorite(userId, recipeId).subscribe({
          next: (added) => {
            this.favorited = true;
          },
          error: (fail: any) => {
            console.error('FavoriteComponent.setFavorite: error');
            console.error(fail);
          },
        });
      }
    }
  }

  removeFavorite(recipe: Recipe) {
    let userId = this.user.id;
    console.log('User ID: ' + userId);
    console.log('Selected Recipe:');
    console.log(this.selected);
    if (this.selected !== null) {
      let recipeId = this.selected.id;
      console.log('Recipe ID: ' + recipeId);
      if (userId !== null && recipeId !== null) {
        console.log('Succeessfully removed Favorite!');
        this.userServ.removeFavorite(userId, recipeId).subscribe({
          next: (removed) => {
            this.favorited = false;
            this.reload();
          },
          error: (fail: any) => {
            console.error('FavoriteComponent.removeFavorite: error');
            console.error(fail);
          },
        });
      }
    }
  }
}
