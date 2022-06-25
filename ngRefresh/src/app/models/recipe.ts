export class Recipe {
  id: number | null;
  name: string | null;
  description: string | null;
  directions: string | null;
  // created
  // updated
  user_id: number | null;
  active: boolean | false;
  prepminutes: number | null;
  cookminutes: number | null;
  imageUrl: string;

  constructor(
    id: number | null = 0,
    name: string | null = '',
    description: string | null = '',
    directions: string | null = '',
    user_id: number | null = 0,
    active: boolean = false,
    prepminutes: number | null = 0,
    cookminutes: number | null = 0,
    imageUrl: string = ''
  ) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.directions = directions;
    this.user_id = user_id;
    this.active = active;
    this.prepminutes = prepminutes;
    this.cookminutes = cookminutes;
    this.imageUrl = imageUrl;
  }
}
