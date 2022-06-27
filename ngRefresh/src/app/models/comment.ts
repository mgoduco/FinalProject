export class Comment {
  id: number | null;
  title: string | null;
  comment: string | null;
  created: string | null;
  active: boolean | false;
  inReplyTo: number | null;
  replies: Comment[] | any;

  constructor(
    id: number | null = 0,
    title: string | null = '',
    comment: string | null = '',
    created: string | null = '',
    active: boolean = false,
    inReplyTo: number | null = 0,
    replies: Comment[] = [],

  ) {
    this.id = id;
    this.title = title;
    this.comment = comment;
    this.created = created;
    this.active = active;
    this.inReplyTo = inReplyTo;
    this.replies = replies;

  }
}
