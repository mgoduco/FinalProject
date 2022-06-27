import { User } from './../models/user';
import { UserService } from './user.service';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Recipe } from '../models/recipe';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root',
})
export class RecipeService {
  private url = environment.baseUrl + 'api/recipes';

  constructor(
    private http: HttpClient,
    private auth: AuthService,
    private user: UserService
  ) {}

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  index(): Observable<Recipe[]> {
    return this.http.get<Recipe[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('RecipeService.index(): error retrieving Recipe: ' + err)
        );
      })
    );
  }

  //?????????????????????????????????
  recipesByUsername(user: User): Observable<Recipe[]> {
    return this.http
      .get<Recipe[]>(this.url + '/u/' + user.username, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'RecipeService.index(): error retrieving Recipes: ' + err
              )
          );
        })
      );
  }

  recipesByNameandIngredient(keyword: string): Observable<Recipe[]> {

    return this.http
      .get<Recipe[]>(this.url + '/search/' + keyword, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'RecipeService.index(): error retrieving Recipes: ' + err
              )
          );
        })
      );

  }

  create(recipe: Recipe): Observable<Recipe> {
    recipe.active = true;
    return this.http.post<Recipe>(this.url, recipe, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () =>
            new Error('RecipeService.create(): error creating Recipe: ' + err)
        );
      })
    );
  }
  update(recipe: Recipe): Observable<Recipe> {
    return this.http
      .put<Recipe>(`${this.url}/${recipe.id}`, recipe, this.getHttpOptions())
      .pipe(
        // return this.http.put<Todo>(`{this.url}/${todo.id}`, todo).pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () =>
              new Error('RecipeService.update(): error updating Recipe: ' + err)
          );
        })
      );
  }

  delete(id: number): Observable<Recipe> {
    return this.http
      .delete<Recipe>(`${this.url}/${id}`, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.error(err);
          return throwError(
            () =>
              new Error('RecipeService.delete(): error deleting Recipe: ' + err)
          );
        })
      );
  }

  show(id: number): Observable<Recipe> {
    return this.http
      .get<Recipe>(`${this.url}/${id}`, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error('RecipeService.show(): error retrieving todo: ' + err)
          );
        })
      );
  }
}
