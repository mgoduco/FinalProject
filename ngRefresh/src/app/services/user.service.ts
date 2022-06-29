import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, Observable, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { Recipe } from '../models/recipe';
import { User } from '../models/user';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root',
})
export class UserService {
  private url = environment.baseUrl + 'api/u';

  constructor(
    private http: HttpClient,
    private auth: AuthService,
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

  getUserById(uid: number): Observable<User> {
    return this.http.get<User>(`${this.url}/${uid}`, this.getHttpOptions()).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError(
            () => new Error('UserService.index(): error retrieving User: ' + err)
          );
        })
      );
  }

  update(user: User): Observable<User> {
    return this.http.put<User>(`${this.url}/${user.id}`, user, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('UserService.update(): error updating User: ' + err)
        );
      })
    );
  }

  disable(id: number): Observable<User> {
    return this.http.delete<User>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('UserService.create(): error deleting User: ' + err)
        );
      })
    );
  }

  getFavorite(rid: number): Observable<boolean> {
    return this.http.get<boolean>(`${this.url}/favorites/${rid}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('UserService.getFavorite(): error getting new Favorite: ' + err)
        );
      })
    );
  }

  getAllFavorites (uid: number): Observable<Recipe[]> {
    return this.http.get<Recipe[]>(`${this.url}/${uid}/favorites`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('UserService.getAllFavorites(): error fetching list of favorite recipes.' + err)
        );
      })
    );
  }

  addFavorite(uid: number, rid: number): Observable<void> {
      return this.http.post<void>(`${this.url}/${uid}/favorites/${rid}`, null, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('UserService.addFavorite(): error creating new Favorite: ' + err)
        );
      })
    );
  }

  removeFavorite(uid: number, rid: number): Observable<void> {
      return this.http.delete<void>(`${this.url}/${uid}/favorites/${rid}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('UserService.removeFavorite(): error removing new Favorite: ' + err)
        );
      })
    );
  }

}
