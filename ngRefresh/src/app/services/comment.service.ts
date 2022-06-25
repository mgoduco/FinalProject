import { User } from './../models/user';
import { Recipe } from './../models/recipe';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { AuthService } from './auth.service';
import { UserService } from './user.service';
import { environment } from 'src/environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { Comment } from '../models/comment';

@Injectable({
  providedIn: 'root',
})
export class CommentService {
  private url = environment.baseUrl + 'api/';

  constructor(
    private http: HttpClient,
    private auth: AuthService,
    private user: UserService,
    private comment: CommentService
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

  getAllCommentsByRecipe(recipe: Recipe): Observable<Comment[]> {
    return this.http.get<Comment[]>(`${this.url}/recipes/${recipe.id}/comments`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('CommentService.index(): error retrieving Comment: ' + err)
        );
      })
    );
  }

  getCommentByRecipe(recipe: Recipe, comment: Comment): Observable<Comment> {
    return this.http.get<Comment>(`${this.url}/recipes/${recipe.id}/comments/${comment.id}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('CommentService.index(): error retrieving Comment: ' + err)
        );
      })
    );
  }

  getCommentsByUser(user: User): Observable<Comment[]> {
    return this.http.get<Comment[]>(`${this.url}/comments/user/${user.username}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () =>
            new Error('CommentService.index(): error retrieving Comment: ' + err)
        );
      })
    );
  }

  create(comment: Comment, recipe: Recipe): Observable<Comment> {
    return this.http.post<Comment>(`${this.url}/recipes/${recipe.id}/comments`,comment, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('CommentService.create(): error creating Comment: ' + err)
        );
      })
    );
  }

  update(comment: Comment, recipe: Recipe): Observable<Comment> {
    return this.http.put<Comment>(`${this.url}/recipes/${recipe.id}/comments/${comment.id}`, comment, this.getHttpOptions()).pipe(
      // return this.http.put<Todo>(`{this.url}/${todo.id}`, todo).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('CommentService.update(): error updating Comment: ' + err)
        );
      })
    );
  }

  delete(id: number): Observable<Comment> {
    return this.http.delete<Comment>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('CommentService.delete(): error deleting Comment: ' + err)
        );
      })
    );
  }

  createReply(comment: Comment, recipe: Recipe): Observable<Comment> {
    return this.http.post<Comment>(`${this.url}/recipes/${recipe.id}/comments`,comment, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('CommentService.create(): error creating Comment: ' + err)
        );
      })
    );
  }

  updateReply(recipe: Comment): Observable<Comment> {
    return this.http.put<Comment>(this.url + '/' + recipe.id, recipe, this.getHttpOptions()).pipe(
      // return this.http.put<Todo>(`{this.url}/${todo.id}`, todo).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('CommentService.update(): error updating Comment: ' + err)
        );
      })
    );
  }

  deleteReply(id: number): Observable<Comment> {
    return this.http.delete<Comment>(`${this.url}/${id}`, this.getHttpOptions()).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError(
          () => new Error('CommentService.delete(): error deleting Comment: ' + err)
        );
      })
    );
  }



}
