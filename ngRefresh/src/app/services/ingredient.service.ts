import { DatePipe } from '@angular/common';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, Observable, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Ingredient } from './../models/ingredient';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root',
})
export class IngredientService {
  private url = environment.baseUrl + 'api/i';

  constructor(
    private http: HttpClient,
    private datePipe: DatePipe,
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

  index(): Observable<Ingredient[]> {
    return this.http
      .get<Ingredient[]>(this.url + '/index', this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'IngredientService.index(): error retrieving ingredient: ' + err
              )
          );
        })
      );
  }

  indexByName(name: String): Observable<Ingredient[]> {
    return this.http
      .get<Ingredient[]>(this.url + '/search/' + {name}, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'IngredientService.indexByName(): error retrieving ingredient: ' +
                  err
              )
          );
        })
      );
  }

  indexByRecipe(id: number): Observable<Ingredient[]> {
    return this.http
      .get<Ingredient[]>(this.url + '/recipe/' + {id}, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'IngredientService.indexByName(): error retrieving ingredient: ' +
                  err
              )
          );
        })
      );
  }

  show(iid: number): Observable<Ingredient> {
    return this.http
      .get<Ingredient>(this.url + '/' + iid, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'IngredientService.show(): error retrieving ingredient: ' + err
              )
          );
        })
      );
  }

  create(ingredient: Ingredient): Observable<Ingredient> {
    return this.http
      .post<Ingredient>(this.url, ingredient, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'IngredientService.create(): error retrieving ingredient: ' +
                  err
              )
          );
        })
      );
  }

  update(ingredient: Ingredient): Observable<Ingredient> {
    return this.http
      .put<Ingredient>(
        this.url + '/' + ingredient.id,
        ingredient,
        this.getHttpOptions()
      )
      .pipe(
        // return this.http.put<Ingredient>(`${this.url}/${ingredient.id}`, ingredient, this.getHttpOptions()).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'IngredientService.update(): error retrieving ingredient: ' +
                  err
              )
          );
        })
      );
  }

  destroy(id: number): Observable<void> {
    return this.http
      .delete<void>(`${this.url}/${id}`, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () =>
              new Error(
                'IngredientService.destroy(): error deleting ingredient: ' + err
              )
          );
        })
      );
  }
}
