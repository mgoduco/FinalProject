import { Recipe } from 'src/app/models/recipe';
import { User } from './user';
export class Comment {
  id: number | null;
  title: string | null;
  comment: string | null;
  // created:
  // updated:
  user: User;
  recipe: Recipe;
  active: boolean | false;
  inReplyTo: number | null;
  replies: Comment[] | any;

  constructor(
    id: number | null = 0,
    title: string | null = '',
    comment: string | null = '',
    user: User,
    recipe: Recipe,
    active: boolean = false,
    inReplyTo: number | null = 0,
    replies: Comment[] = [],

  ) {
    this.id = id;
    this.title = title;
    this.comment = comment;
    this.user = user;
    this.recipe = recipe;
    this.active = active;
    this.inReplyTo = inReplyTo;
    this.replies = replies;

  }
}
