import { RecipeService } from 'src/app/services/recipe.service';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { User } from '../models/user';
import { AuthService } from './auth.service';
import { Observable, catchError, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';

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

  getUserById(user: User): Observable<User> {
    return this.http.get<User>(`${this.url}/${user.id}`, this.getHttpOptions()).pipe(
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
      // return this.http.put<Todo>(`{this.url}/${todo.id}`, todo).pipe(
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

}
