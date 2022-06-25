export class Comment {
  id: number | null;
  title: string | null;
  comment: string | null;
  // created:
  // updated:
  user_id: number | null;
  recipe_id: number | null;
  active: boolean | false;
  in_reply_to: number | null;

  constructor(
    id: number | null = 0,
    title: string | null = '',
    comment: string | null = '',
    user_id: number | null = 0,
    recipe_id: number | null = 0,
    active: boolean = false,
    in_reply_to: number | null = 0
  ) {
    this.id = id;
    this.title = title;
    this.comment = comment;
    this.user_id = user_id;
    this.recipe_id = recipe_id;
    this.active = active;
    this.in_reply_to = in_reply_to;
  }
}
