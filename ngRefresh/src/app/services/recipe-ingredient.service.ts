import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, tap, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { RecipeIngredient } from '../models/recipe-ingredient';
import { AuthService } from './auth.service';
@Injectable({
  providedIn: 'root',
})
export class RecipeIngredientService {
  private url = environment.baseUrl + 'api/recipes';

  constructor(
    private http: HttpClient,
    private auth: AuthService
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

  getForRecipe(id: number): Observable<RecipeIngredient[]> {
    return this.http
      .get<RecipeIngredient[]>(`${this.url}/${id}/ingredients`)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'RecipeIngredient.index(): error retrieving RecipeIngredients: ' +
                  err
              )
          );
        })
      );
  }

  create(rIngredient: RecipeIngredient, rid: number, iid: number): Observable<RecipeIngredient> {
    return this.http.post<RecipeIngredient>(`${this.url}/${rid}/ingredients/${iid}`, rIngredient, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('recipeingredient.create(): error creating recipe ingredient: ' + err)
        );
      })
    );
  }

  update(rIngredient: RecipeIngredient, rid: number, iid: number): Observable<RecipeIngredient> {
    return this.http
      .put<RecipeIngredient>(`${this.url}/${rid}/ingredients/${iid}`, rIngredient, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'RecipeIngredient.update(): error updating RecipeIngredients: ' +
                  err
              )
          );
        })
      );
  }

  delete(rid: number, iid: number): Observable<void> {
    return this.http
      .delete<void>(`${this.url}/${rid}/ingredients`)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'RecipeIngredient.delete(): error deleting RecipeIngredients: ' +
                  err
              )
          );
        })
      );
  }
}

  // create(id: number,rIngredient: RecipeIngredient): Observable<RecipeIngredient> {
  //   return this.http
  //     .get<RecipeIngredient>(`${this.url}/${id}/ingredients`, rIngredient, this.getHttpOptions())
  //     .pipe(
  //       catchError((err: any) => {
  //         console.log(err);
  //         return throwError(
  //           () =>
  //             new Error(
  //               'RecipeIngredient.index(): error retrieving RecipeIngredients: ' +
  //                 err
  //             )
  //         );
  //       })
  //     );
  // }

